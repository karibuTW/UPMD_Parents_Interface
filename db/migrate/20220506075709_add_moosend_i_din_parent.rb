class AddMoosendIDinParent < ActiveRecord::Migration[6.1]
  def change
    add_column :parents ,:moosend_id , :string
    add_column :secondary_parents ,:moosend_id , :string
  end
end
