Sequel.migration do
  change do
    create_table(:categories) do
      primary_key :id, index: true
      String :name, size: 32, unique: true, null: false
    end
  end
end
