module ExpenseTracker
  class ProfileController < BaseController
    NAMESPACE = '/profile'

    before do
      redirect '/' unless logged?
      @title = 'Profile'
    end

    get '/' do
      erb :'profile.html'
    end
  end
end