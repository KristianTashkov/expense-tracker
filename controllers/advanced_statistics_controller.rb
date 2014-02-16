module ExpenseTracker
  class AdvancedStatisticsController < BaseController
    NAMESPACE = '/advanced-statistics'

    before do
      redirect '/' unless logged?
      @title = "Advanced Statistics"
    end

    get '/' do
      erb :'statistics.html'
    end

  end
  ExpenseTracker::navigation_links[AdvancedStatisticsController] = NavigationLink.new("/advanced-statistics", "Advanced Statistics", true, 3);
end