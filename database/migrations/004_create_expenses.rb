Sequel.migration do
  change do
    create_table(:expenses) do
      primary_key :id, index: true
      foreign_key :subcategory_id, :subcategories, null: false
      foreign_key :user_id, :users, null: false
      Double :ammount, null: false
      Double :ammount_usd, null: false
      String :description
      DateTime :date, null: false
    end
  end
end
