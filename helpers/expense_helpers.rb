module ExpenseHelpers
  CHARTS_MAX_ITEMS = 10

  def generate_chart_data(startPeriod, endPeriod, subcategory_ids = nil)
    all_expenses = get_expenses(startPeriod, endPeriod, subcategory_ids)

    categories_chart_data = all_expenses.group_by { |expense| expense.subcategory.category }
      .map do |category, expenses|
        [category.name, expenses.map(&:ammount).reduce(&:+)]
      end

    subcategories_chart_data = all_expenses.group_by { |expense| expense.subcategory}
      .map do |subcategory, expenses|
        ["#{subcategory.category.name}/#{subcategory.name}", expenses.map(&:ammount).reduce(&:+)]
      end

    expenses_line_data = all_expenses.group_by { |expense| expense.date.to_date }
      .map do |date, expenses|
        ammount = expenses.map(&:ammount).reduce(&:+)
        [date, ammount]
      end

    {
      categories_chart_data: trim_statistics_data(categories_chart_data),
      subcategories_chart_data: trim_statistics_data(subcategories_chart_data),
      expenses_line_data: expenses_line_data
    }
  end

  def get_expenses(startPeriod, endPeriod, subcategory_ids = nil)
    dataset = Expense.where(user_id: logged_user.id).where(date: startPeriod..endPeriod)
    dataset = dataset.where(subcategory_ids: subcategory_ids) if subcategory_ids
    dataset.to_a
  end

  def trim_statistics_data(data)
    return data if data.count <= CHARTS_MAX_ITEMS
    last = data.drop(CHARTS_MAX_ITEMS - 1).map {|_, ammount| ammount};
    data.take(CHARTS_MAX_ITEMS - 1) + [["Others", last.reduce(&:+)]]
  end
end