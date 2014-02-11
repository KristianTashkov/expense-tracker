Sequel.migration do
  change do
    create_table(:expenses) do
      primary_key :id, index: true
      foreign_key :subcategory_id, :subcategories, null: false
      foreign_key :user_id, :users, null: false
      Double :ammount, null: false
      Date :date, null: false
    end
  end
end
