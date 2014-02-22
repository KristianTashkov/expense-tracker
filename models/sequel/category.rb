class Category < Sequel::Model
  one_to_many :subcategories

  def expenses
    subcategories.flat_map { |subcategory| subcategory.expenses }
  end
end
