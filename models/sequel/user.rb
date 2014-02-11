class User < Sequel::Model
  many_to_many :subcategories
  one_to_many :expenses
end
