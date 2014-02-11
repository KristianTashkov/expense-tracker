Sequel.migration do
  change do
    create_table(:subcategories) do
      primary_key :id, index: true
      String :name, size: 32, unique: true, null: false
      foreign_key :category_id, :categories, null: false
    end
  end
end
