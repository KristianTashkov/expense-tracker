module ExpenseTracker
  class BaseController < Sinatra::Base
    helpers HTMLGenerator
    helpers UserHelper

    not_found do
      @title = "404: Wrong page"
      erb :'not_found.html'
  end
  end
end