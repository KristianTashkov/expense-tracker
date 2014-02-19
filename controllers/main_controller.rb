module ExpenseTracker
  class MainController < BaseController
    NAMESPACE = '/'

    before do
      @title = 'Register'
    end

    get '/' do
      redirect '/profile' if logged?
      erb :'index.html', :locals => {:error_message => nil}
    end

    post '/logout' do
      set_logged_user_id 0
      redirect '/'
    end

    post '/login' do
      @login_username  = params[:login_username]
      login_password = params[:login_password]
      secure_password = get_secure_password login_password

      user = User.find(username: @login_username, password: secure_password);
      if user
        set_logged_user_id user.id
        redirect '/profile'
      end

      @global_error_message = "Wrong username and password combination! Not a user?"
      erb :'index.html', :locals => {:error_message => nil}
    end

    post '/register' do
      @username  = params[:username].to_s
      @email    = params[:email].to_s.downcase
      @password1 = params[:password1].to_s
      @password2 = params[:password2].to_s
      @currency = 'USD'

      error_message = validate_new_user(@username, @email, @password1, @password2);
      if(error_message)
        erb :'index.html', :locals => {:error_message => error_message }
      else
        secure_password = get_secure_password @password1
        user = User.create(username: @username, email: @email, password: secure_password, currency: @currency)
        user.add_default_categories
        session[:user_id] = user.id
        redirect '/'
      end
    end
  end
end