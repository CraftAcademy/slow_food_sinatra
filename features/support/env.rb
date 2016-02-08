# Generated by cucumber-sinatra. (2015-11-10 09:26:28 +0100)

ENV['RACK_ENV'] = 'test'

require './lib/controller.rb'

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'pry'

Capybara.app = SlowFood

class SlowFoodWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  SlowFood.new
end