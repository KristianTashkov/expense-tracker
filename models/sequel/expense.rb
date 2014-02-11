class Expense < Sequel::Model
  many_to_one :user
  many_to_one :subcategory
end
