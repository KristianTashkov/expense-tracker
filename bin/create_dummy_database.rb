require 'Sequel'
require './helpers/user_helper'

include UserHelpers

system "rm database/database.db"
system "sequel -m  database/migrations sqlite://database/database.db"
DB = Sequel.sqlite "database/database.db"

Dir['./{models}/**/*.rb'].each { |file| require file }

subcategories = [["Food", "Groceries"],
                         ["Food", "Dinning"],
                         ["Food", "Fast Food"],
                         ["Entertainment", "Alcohol"],
                         ["Entertainment", "Games"]]
module ExpenseTracker
  STARTING_SUBCATEGORY_COUNT = 5
end

categories = subcategories.map(&:first).uniq

users = [{username: "kris", email: "kris@google.com", password: get_secure_password("123456"), currency: "USD"},
         {username: "gosho", email: "gosho@google.com", password: get_secure_password("123456"), currency: "USD"}]

categories.each { |category| Category.create(name: category) }
subcategories.each { |category, subcategory| Subcategory.create(name: subcategory, category_id: categories.index(category) + 1)}
users.each { |user| User.create(user).add_default_categories }

User.all[0].add_expense(subcategory_id: 1, ammount: 10, ammount_usd: 10, date: DateTime.now)
User.all[1].add_expense(subcategory_id: 4, ammount: 20, ammount_usd: 20, date: DateTime.now)
