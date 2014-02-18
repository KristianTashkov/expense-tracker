ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'test/unit'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each) do
    ExpenseTracker::BaseController::DB.tables.each do |table|
      ExpenseTracker::BaseController::DB[table].truncate
      @session = {}
    end
  end
end

def session
  @session
end

def create_user(params = {})
  user_params = {username: "default_username", password: "default_password", email: "default_email", currency: "USD"}
  params.each { |key, value| user_params[key] = value}
  User.create(user_params)
end

def app
  ExpenseTracker::BaseController
end