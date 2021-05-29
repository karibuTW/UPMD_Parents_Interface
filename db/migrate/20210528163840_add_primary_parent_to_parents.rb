class AddPrimaryParentToParents < ActiveRecord::Migration[6.1]
  def change
    change_table :parents do |t|
      t.references :primary_parent, foreign_key: { to_table: :parents }
    end
  end
end
