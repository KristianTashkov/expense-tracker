require 'Sequel'

system "rm database/database.db"
system "sequel -m  database/migrations sqlite://database/database.db"
DB = Sequel.sqlite "database/database.db"

Dir['./{models}/**/*.rb'].each { |file| require file }

subcategories = [["Food", "Groceries"],
                         ["Food", "Dinning"],
                         ["Food", "Fast Food"],
                         ["Entertainment", "Alcohol"],
                         ["Entertainment", "Games"]]

categories = subcategories.map(&:first).uniq

users = [{username: "kris", email: "kris@google.com", password: "123", currency: "USD"},
         {username: "gosho", email: "gosho@google.com", password: "123", currency: "USD"}]

categories.each { |category| Category.create(name: category) }
subcategories.each { |category, subcategory| Subcategory.create(name: subcategory, category_id: categories.index(category) + 1)}
users.each { |user| User.create(user) }

User.all[0].add_expense(subcategory_id: 1, ammount: 10, date: DateTime.now)
User.all[1].add_expense(subcategory_id: 4, ammount: 20, date: DateTime.now)
