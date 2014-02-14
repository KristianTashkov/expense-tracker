module ExpenseTracker
  class StatisticsController < BaseController
    NAMESPACE = '/statistics'
    CHARTS_MAX_ITEMS = 10

    before do
      redirect '/' unless logged?
      @title = "Statistics"
    end

    get '/' do
      @categories_chart_data = logged_user.expenses.group_by { |expense| expense.subcategory.category }
        .map do |category, expenses|
          [category.name, expenses.map(&:ammount).reduce(&:+)]
        end

      @categories_chart_data = trim_statistics_data @categories_chart_data

      @subcategories_chart_data = logged_user.expenses.group_by { |expense| expense.subcategory}
        .map do |subcategory, expenses|
          ["#{subcategory.category.name}/#{subcategory.name}", expenses.map(&:ammount).reduce(&:+)]
        end

      @subcategories_chart_data = trim_statistics_data @subcategories_chart_data

      erb :'statistics.html'
    end

    def trim_statistics_data(data)
      return data if data.count <= CHARTS_MAX_ITEMS
      last = data.drop(CHARTS_MAX_ITEMS - 1).map {|_, ammount| ammount};
      data.take(CHARTS_MAX_ITEMS - 1) + [["Others", last.reduce(&:+)]]
    end
  end

  ExpenseTracker::navigation_links[StatisticsController] = NavigationLink.new("/statistics", "Statistics", true, 2);
end