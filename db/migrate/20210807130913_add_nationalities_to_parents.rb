class AddNationalitiesToParents < ActiveRecord::Migration[6.1]
  def change
    add_column :parents, :nationalities, :string, array: true, default: []
  end
end
