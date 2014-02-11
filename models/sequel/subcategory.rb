class Subcategory < Sequel::Model
  many_to_many :users
  many_to_one :category
  one_to_many :expenses
end
