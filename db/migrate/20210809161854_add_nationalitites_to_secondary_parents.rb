class AddNationalititesToSecondaryParents < ActiveRecord::Migration[6.1]
  def change
    add_column :secondary_parents, :nationalities, :string, array: true, default: []
  end
end
