Sequel.migration do
  up do
    create_table(:accounts) do
      primary_key :id
      String :address, :null=>false
      Integer :balance
    end
  end

  down do
    drop_table(:accounts)
  end
end