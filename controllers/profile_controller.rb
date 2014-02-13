module ExpenseTracker
  class ProfileController < BaseController
    NAMESPACE = '/profile'

    before do
      redirect '/' unless logged?
      @title = "Welcome, #{logged_user.username}"
      update_expenses
    end

    get '/' do
      erb :'profile.html', :locals => {:error_message => nil}
    end

    post '/add-expense' do
      @subcategory_id = params[:expenseSubcategory].to_i
      @ammount = params[:expenseAmmount].to_f
      @description = params[:expenseDescription].to_s

      if(@subcategory_id.zero? || @ammount.zero?)
        @expense_error_message = "Invalid entry data!"
        return erb :'profile.html'
      end

      logged_user.add_expense(subcategory_id: @subcategory_id, ammount: @ammount, ammount_usd: @ammount, date: DateTime.now, description: @description);
      @ammount = "";
      @description = "";
      @expense_success_message = "Succesfully added new expense!"
      update_expenses
      return erb :'profile.html'
    end

    get '/delete-expense' do
      id = params[:id].to_i
      expense = Expense.find(id: id, user_id: logged_user.id)
      if expense
        expense.delete
      end

      nil
    end

    def update_expenses
      page = params[:page].to_i
      page = 1 if page.zero?

      @expenses = Expense.where(:user_id => logged_user.id).order(Sequel.desc(:date)).paginate(page, 10)
    end
  end
  ExpenseTracker::navigation_links[ProfileController] = NavigationLink.new("/profile", "Profile", true, 1);
end