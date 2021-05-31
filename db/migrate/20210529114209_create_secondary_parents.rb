class CreateSecondaryParents < ActiveRecord::Migration[6.1]
  def change
    create_table :secondary_parents do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :full_name, null: false
      t.string :phone_number, null: false
      t.string :address, null: false
      t.integer :preferred_language, null: false, default: 0
      t.references :parent, null: false, foreign_key: true
      t.string :email, null: false

      t.timestamps
    end
  end
end
