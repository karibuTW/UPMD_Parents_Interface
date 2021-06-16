class CreateDiscountCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.string :owner
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :discount_codes, :code, unique: true
  end
end
