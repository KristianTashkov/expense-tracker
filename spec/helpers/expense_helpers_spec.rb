require 'spec_helper'

module ExpenseTracker
  describe ExpenseHelpers do
    include ExpenseHelpers
    include UserHelpers

    before(:each) do
      set_logged_user_id create_user().id
    end

    describe "#get_expenses" do
      it "should return all expenses for a period" do
        category = create_category "1"
        subcategory = create_subcategory("1/1", category.id)
        first_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id })
        second_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id })

        expenses = get_expenses(DateTime.now - 1, DateTime.now).to_a 
        expenses.include?(first_expense).should be_true
        expenses.include?(second_expense).should be_true
      end

      it "should return all expenses in descending order by date" do
        category = create_category "1"
        subcategory = create_subcategory("1/1", category.id)
        first_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id })
        second_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id })

        expenses = get_expenses(DateTime.now - 1, DateTime.now).to_a 
        expenses.should eq([second_expense, first_expense])
      end

      it "should not return expenses not in the period" do
        category = create_category "1"
        subcategory = create_subcategory("1/1", category.id)
        first_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id })
        second_expense = add_expense_to_user(logged_user, {subcategory_id: subcategory.id, date: DateTime.now - 2 })

        get_expenses(DateTime.now - 1, DateTime.now).to_a.should eq([first_expense])
      end

      it "should only return expenses matching subcategory ids" do
        category = create_category "1"
        first_subcategory = create_subcategory("1/1", category.id)
        second_subcategory = create_subcategory("1/2", category.id)
        first_expense = add_expense_to_user(logged_user, {subcategory_id: first_subcategory.id })
        second_expense = add_expense_to_user(logged_user, {subcategory_id: second_subcategory.id})

        get_expenses(DateTime.now - 1, DateTime.now, [first_subcategory.id]).to_a.should eq([first_expense])
      end
    end

    describe "#trim_statistics_data" do
      it "Shouldn't trim when there are less than 10 items" do
        data = [["Food", 10], ["Bills", 20]]
        trim_statistics_data(data).should eq(data)
      end

      it "Shouldn trim when there are more than 10 items" do
        data = 
        [
          ["Food0", 10],
          ["Food1", 10],
          ["Food2", 10],
          ["Food3", 10],
          ["Food4", 10],
          ["Food5", 10],
          ["Food6", 10],
          ["Food7", 10],
          ["Food8", 10],
          ["Food9", 10],
          ["Food10", 10]
        ]

        expected_data = data.take(9).push(["Others", 20])
        trim_statistics_data(data).should eq(expected_data)
      end
    end
  end
end