class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :full_name, null: false
      t.date :birth_date, null: false
      t.integer :grade, default: 0
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
