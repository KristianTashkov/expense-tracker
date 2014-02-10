module ExpenseTracker
  class MainController < BaseController
    NAMESPACE = '/'

    before do
      @title = 'Register'
    end
    get '/' do
      redirect '/home' if logged?
      erb :'index.html', :locals => {:error_message => nil}
    end

    post '/logout' do
      session[:user_id] = nil
      redirect '/'
    end

    post '/login' do
      @login_username  = params[:login_username]
      login_password = params[:login_password]
      secure_password = get_secure_password login_password

      user = User.find(username: @login_username, password: secure_password);
      if user
        session[:user_id] = user.id
        redirect '/home'
      end

      @global_error_message = "Wrong username and password combination! Not a user?"
      erb :'index.html', :locals => {:error_message => nil}
    end

    post '/register' do
      @username  = params[:username]
      @email    = params[:email]
      @password1 = params[:password1]
      @password2 = params[:password2]
      @currency = 'USD'

      error_message = validate_new_user(@username, @email, @password1, @password2);
      if(error_message)
        erb :'index.html', :locals => {:error_message => error_message }
      else
        secure_password = get_secure_password @password1
        user = User.create(username: @username, email: @email, password: secure_password, currency: @currency)
        session[:user_id] = user.id
        redirect '/'
      end
    end
  end
end