# require 'sinatra'
require 'bundler'
Bundler.require
require 'sinatra/form_helpers'
Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each { |file| require file }
# require 'dm-timestamps'
require_relative 'helpers/data_mapper'
require_relative 'helpers/warden'
require_relative 'helpers/menu_helpers'

require 'pry'
require 'tilt/erb'


class SlowFood < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Contrib
  register Sinatra::Warden
  helpers Sinatra::FormHelpers
  helpers MenuHelpers
  set :session_secret, 'supersecret'

  use Warden::Manager do |config|
    # Tell Warden how to save our User info into a session.
    # Sessions can only take strings, not Ruby code, we'll store
    # the User's `id`
    config.serialize_into_session(&:id)
    # Now tell Warden how to take what we've stored in the session
    # and get a User from that information.
    config.serialize_from_session { |id| User.get(id) }

    config.scope_defaults :default,
                          # "strategies" is an array of named methods with which to
                          # attempt authentication. We have to define this later.
                          strategies: [:password],
                          # The action is a route to send the user to when
                          # warden.authenticate! returns a false answer. We'll show
                          # this route below.
                          action: 'auth/unauthenticated'
    # When a user tries to log in and cannot, this specifies the
    # app to send the user to.
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env, _opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  get '/' do
    erb :index
  end

  namespace '/auth' do
    get '/login' do
      erb :login
    end

    post '/login' do
      env['warden'].authenticate!
      flash[:success] = "Successfully logged in #{current_user.username}"
      if session[:return_to].nil?
        redirect '/'
      else
        redirect session[:return_to]
      end
    end

    get '/admin/register' do
      erb :admin_register
    end

    get '/register' do
      erb :register
    end

    post '/admin/register' do
      user = User.new(
          username: params[:user][:username],
          password: params[:user][:password],
          password_confirmation: params[:user][:password_confirmation],
          admin: true
      )
      begin
        user.save
        flash[:success] = "Successfully created account for #{user.username}"
        redirect '/'
      rescue
        flash[:error] = user.errors.full_messages.join(',')
      end
    end

    post '/register' do
      user = User.new(
          username: params[:user][:username],
          password: params[:user][:password],
          password_confirmation: params[:user][:password_confirmation],
          email: params[:user][:email],
          phone_number: params[:user][:phone_number]
      )
      begin
        user.save
        env['warden'].authenticate!
        flash[:success] = "Successfully created account for #{current_user.username}"
        redirect '/'
      rescue
        flash[:error] = user.errors.full_messages.join(',')
      end
      redirect '/auth/register'
    end

    get '/logout' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      flash[:success] = 'Successfully logged out'
      redirect '/'
    end

    post '/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

      # Set the error and use a fallback if the message is not defined
      flash[:error] = env['warden.options'][:message] || 'You must log in'
      redirect '/auth/login'
    end
  end

  get '/menu' do
    @dishes = Dish.all.group_by(&:category_id)
    erb :menu
  end

  post '/menu/add_to_basket' do
    dish = Dish.get(params[:basket_item][:id])

    if session[:b_id]
      basket = Basket.get(session[:b_id])
    else
      basket = Basket.create(user: current_user)
      session[:b_id] = basket.id
    end

    BasketItem.create(qty: params[:basket_item][:qty].to_i, dish: dish, basket: basket)

    flash[:success] = "#{dish.name} added to your basket"
    redirect '/menu'
  end

  get '/check_out' do
    env['warden'].authenticate!
    @basket = Basket.get(session[:b_id])
    erb :basket
  end

  post '/check_out' do
    @basket = Basket.get(session[:b_id])
    session.tap { |hs| hs.delete(:b_id) }
    erb :order_confirm
  end

  get '/cancel_order' do
    session.tap { |hs| hs.delete(:b_id) }
    flash[:error] = 'Your order was cancelled'
    redirect '/menu'
  end

  get '/menu/add_dish' do
    env['warden'].authenticate!
    erb :add_dish
  end

  post '/menu/add_dish' do
    category = Category.get(params[:dish][:category])
    dish = Dish.new(
        name: params[:dish][:name],
        price: params[:dish][:price],
        category: category,
        user: current_user
    )
    if current_user.admin == true
      dish.save
      flash[:success] = "Successfully added #{dish.name}"
    else
      flash[:error] = 'Sorry!, you are not authorized to add dishes'
    end
    redirect '/'
  end

  get '/protected' do
    env['warden'].authenticate!
    erb :protected
  end
end
