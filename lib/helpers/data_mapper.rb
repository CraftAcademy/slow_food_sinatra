env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://mazen@localhost/slowfood_v1_#{env}")
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize
DataMapper.auto_upgrade!
# DataMapper.auto_migrate!

if ENV['RACK_ENV'] != 'test'
  # Set up the required entries in the db
  ['Starter', 'Main course', 'Dessert'].each do |category|
    Category.first_or_create(name: category)
  end
  user = User.first(username: 'Admin')
  User.create(username: 'Admin',
              password: 'password',
              password_confirmation: 'password',
              admin: true
             ) unless user
end
