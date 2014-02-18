require 'spec_helper'

module ExpenseTracker
  describe CategoryHelpers do
    include CategoryHelpers

    describe "#validate_category_name" do
      it "should return error message if category name is too short" do
        validate_category_name("", true).should_not be_nil
        validate_category_name("", false).should_not be_nil
      end

      it "should return error message if category name has invalid characters" do
        validate_category_name("Категория", true).should_not be_nil
        validate_category_name("Подкатегория", false).should_not be_nil
      end

      it "should return error message with correct string for category or subcategory" do
        validate_category_name("", false).include?("Category").should be_true
        validate_category_name("", true).include?("Sub-category").should be_true
      end

      it "should return nil if correct category name is passed" do
        validate_category_name("Category", true).should be_nil
        validate_category_name("Sub-category", false).should be_nil
      end
    end
  end
end