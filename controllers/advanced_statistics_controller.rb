module ExpenseTracker
  class AdvancedStatisticsController < BaseController
    NAMESPACE = '/advanced-statistics'

    before do
      redirect '/' unless logged?
      @title = "Advanced Statistics"
    end

    get '/' do
      erb :'advanced_statistics.html'
    end

    get '/results' do
      page = params[:page].to_i
      page = 1 if page.zero?
      start_date = Date.parse(params[:startDate].to_s) rescue nil
      end_date = Date.parse(params[:endDate].to_s) rescue nil

      if(not(start_date) || not(end_date))
        @global_error_message = "Wrong date format!" + start_date.to_s + end_date.to_s
        return erb :'advanced_statistics.html'
      end

      subcategory_fields = params.select { |key, value| key.to_s.start_with?("subcategoryId") }
      subcategory_ids = subcategory_fields.select { |_, value| value }.map { |key, _| /\d+/.match(key).to_s.to_i }
      if(subcategory_ids.size == logged_user.subcategories.size)
        subcategory_ids = nil
      end

      @charts_data = generate_chart_data(start_date, end_date, subcategory_ids)

      @shown_results = @charts_data[:dataset].paginate(page, 10)
      erb :'advanced_statistics_results.html'
    end

  end
  ExpenseTracker::navigation_links[AdvancedStatisticsController] = NavigationLink.new("/advanced-statistics", "Advanced Statistics", true, 3);
end