class AddUniqueIndexToBusServices < ActiveRecord::Migration[6.1]
  def change
    add_index :bus_services, [:parent_id, :year], unique: true
  end
end
