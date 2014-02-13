module ExpenseTracker
  class CategoryController < BaseController
    NAMESPACE = '/categories'

    before do
      redirect '/' unless logged?
      @title = "Manage Categories"

      update_categories
    end

    get '/' do
      erb :'manage_categories.html'
    end

    get '/delete-category' do
      id = params[:id].to_i
      subcategories = logged_user.subcategories.select { |subcategory| subcategory.category.id == id }
      subcategories.each { |subcategory| delete_subcategory(subcategory.id) }
      "success"
    end

    get '/delete-subcategory' do
      id = params[:id].to_i
      delete_subcategory id
      "success"
    end

    post '/create-category' do
      category_id = params[:category].to_i
      category_name = params[:categoryName].to_s.downcase.capitalize
      subcategory_name = params[:subcategoryName].to_s.downcase.capitalize

      if category_id.zero?
        @error_message = validate_category_name(category_name, is_subcategory = false)
        if @error_message
          return erb :'manage_categories.html'
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
          update_categories
          @success_message = "Category created succesfully!"
        else
          @error_message = "Category already exists!"
        end
      end
      return erb :'manage_categories.html'
    end

    def update_categories
      @categories = logged_user.subcategories.group_by { |subcategory| subcategory.category }
    end

    def delete_subcategory(id)
      expenses_to_delete = logged_user.expenses.select { |expense| expense.subcategory.id == id }
      expenses_to_delete.each { |expense| expense.delete }
      logged_user.remove_subcategory(Subcategory.find(id: id));
    end
  end

  ExpenseTracker::navigation_links[CategoryController] = NavigationLink.new("/categories/", "Manage Categories", true, 10);
end