class AddConditionsToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :conditions, :string
  end
end
