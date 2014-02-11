Sequel.migration do
  change do
    create_table(:subcategories_users) do
      primary_key :id
      foreign_key :user_id, :users
      foreign_key :subcategory_id, :subcategories
      unique [:user_id, :subcategory_id]
    end
  end
end
