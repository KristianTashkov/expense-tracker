module ExpenseTracker
  class BaseController < Sinatra::Base
    helpers HTMLGenerator
    helpers UserHelpers
    helpers CategoryHelpers
    helpers ExpenseHelpers

    before do
      @shown_navigation_links = ExpenseTracker::navigation_links.each do |controller, link|
        link.active = controller == self.class
      end.values.sort_by(&:priority)

      if(not logged?)
        @shown_navigation_links = @shown_navigation_links.reject { |link| link.require_logged }
      end
    end

    not_found do
      @title = "404: Wrong page"
      erb :'not_found.html'
  end
  end
end