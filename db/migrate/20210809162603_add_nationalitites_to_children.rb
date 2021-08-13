class AddNationalititesToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :nationalities, :string, array: true, default: []
  end
end
