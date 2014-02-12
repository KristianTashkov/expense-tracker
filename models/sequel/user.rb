class User < Sequel::Model
  many_to_many :subcategories
  one_to_many :expenses

  def add_default_categories
    Subcategory.where { id <= ::ExpenseTracker::STARTING_SUBCATEGORY_COUNT }.to_a.each do |subcategory|
      add_subcategory(subcategory)
    end
  end

  def categories
    subcategories.map { |subcategory| subcategory.category }.uniq
  end
end
