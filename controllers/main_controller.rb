module ExpenseTracker
  class MainController < BaseController
    NAMESPACE = '/'

    get '/' do
      erb :'index.html'
    end
  end
end