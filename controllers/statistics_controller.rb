module ExpenseTracker
  class StatisticsController < BaseController
    NAMESPACE = '/statistics'

    before do
      redirect '/' unless logged?
      @title = "Statistics"
    end

    get '/' do
      erb :'statistics.html'
    end

  end
  ExpenseTracker::navigation_links[StatisticsController] = NavigationLink.new("/statistics", "Statistics", true, 2);
end