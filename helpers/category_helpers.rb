module CategoryHelpers
  def validate_category_name(name, is_subcategory)
    category_class_string = is_subcategory ? "Sub-category" : "Category"
    return "#{category_class_string} name should be atleast 3 characters long" if name.length < 3
    return "#{category_class_string} name contains invalid characters" if /[a-zA-Z]*/.match(name).to_s != name
  end
end