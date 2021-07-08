class AddBusToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :taking_bus, :boolean, default: false
  end
end
