class Category < Sequel::Model
  one_to_many :subcategories

  def expenses
    subcategories.map { |subcategory| subcategory.expenses }.flatten
  end
end
