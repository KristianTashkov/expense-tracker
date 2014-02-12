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

    post '/create-category' do
      category_id = params[:category].to_i
      category_name = params[:categoryName].to_s.downcase.capitalize
      subcategory_name = params[:subcategoryName].to_s.downcase.capitalize

      if category_id.zero?
        @error_message = validate_category_name(category_name, is_subcategory = false)
        if @error_message
          return erb :'profile.html'
        end

        existing_category = Category.find(name: category_name)
        category_id = existing_category ? existing_category.id : Category.create(name: category_name).id
      end

      @error_message = validate_category_name(subcategory_name, is_subcategory = true)
      if (not @error_message)
        existing_category = Subcategory.find(name: subcategory_name, category_id: category_id);
        subcategory = existing_category ? existing_category : Subcategory.create(category_id: category_id, name: subcategory_name)
        if(not logged_user.subcategories.include?(subcategory))
          logged_user.add_subcategory(subcategory);
          @success_message = "Category created succesfully!"
        else
          @error_message = "Category already exists!"
        end
      end
      return erb :'profile.html'
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
end