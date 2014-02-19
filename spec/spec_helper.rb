ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'test/unit'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:each) do
    @session = {}

    failed_table = true
    while failed_table
      failed_table = false
      ExpenseTracker::BaseController::DB.tables.each do |table|
        begin      
          ExpenseTracker::BaseController::DB[table].delete
        rescue Sequel::ForeignKeyConstraintViolation
          failed_table = true
        end
      end
    end
  end
end

def session
  @session
end

def create_category(name)
  Category.create(name: name)
end

def create_subcategory(name, category_id)
  Subcategory.create(name: name, category_id: category_id)
end

def create_user(params = {})
  user_params = {username: "default_username", password: "default_password", email: "default_email", currency: "USD"}
  params.each { |key, value| user_params[key] = value}
  User.create(user_params)
end

def add_expense_to_user(user, params)
  expense_params = { user_id: user.id, ammount:10, ammount_usd: 10, date: DateTime.now }
  params.each { |key, value| expense_params[key] = value}
  user.add_expense(expense_params)
end

def app
  ExpenseTracker::BaseController
end