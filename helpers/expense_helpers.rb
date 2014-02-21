module ExpenseHelpers
  CHARTS_MAX_ITEMS = 10

  def generate_chart_data(start_period, end_period, subcategory_ids = nil)
    dataset = get_expenses(start_period, end_period, subcategory_ids)
    all_expenses = dataset.to_a
    return { success: false } if all_expenses.empty?

    total_spent = all_expenses.map { |expense| expense.ammount }.reduce(&:+)
    dates = all_expenses.map(&:date)
    total_days_spending = (dates.max.to_date - dates.min.to_date).to_i
    total_days_spending = 1 if total_days_spending.zero?
    average_per_day = total_spent / total_days_spending
    expenses_count = all_expenses.size

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
      success: true,
      dataset: dataset,
      total_spent: total_spent,
      total_days_spending: total_days_spending,
      average_per_day: average_per_day,
      expenses_count: expenses_count,
      categories_chart_data: trim_statistics_data(categories_chart_data),
      subcategories_chart_data: trim_statistics_data(subcategories_chart_data),
      expenses_line_data: expenses_line_data
    }
  end

  def get_expenses(start_period, end_period, subcategory_ids = nil)
    dataset = Expense.where(user_id: logged_user.id).where(date: start_period..end_period.next_day)
    dataset = dataset.where(subcategory_id: subcategory_ids) if subcategory_ids
    dataset.order(Sequel.desc(:date))
  end

  def trim_statistics_data(data)
    return data if data.count <= CHARTS_MAX_ITEMS
    last = data.drop(CHARTS_MAX_ITEMS - 1).map {|_, ammount| ammount};
    data.take(CHARTS_MAX_ITEMS - 1) + [["Others", last.reduce(&:+)]]
  end

  def format_currency_string(ammount)
    sprintf("%.2f #{logged_user.currency}", ammount)
  end
end