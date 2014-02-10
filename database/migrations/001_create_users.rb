Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, index: true
      String :username, size: 32, unique: true, null: false
      String :password, size: 40, null: false
      String :email, null: false, unique: true
      String :currency, null: false
    end
  end
end
