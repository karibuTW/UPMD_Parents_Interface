class CreateHelloassoOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :helloasso_order_items do |t|
      t.references :helloasso_order, {null: false, foreign_key: true }
      t.string :order_item_id
      t.datetime :date
      t.decimal :amount
      t.boolean :cancelled, default: false
      t.integer :order_item_type, default: 0
      t.integer :state, default: 0
      t.string :ticket_url
      t.string :membership_card_url
      t.integer :price_category, default: 0
      t.string :discount_code
      t.decimal :discount_amount
      t.timestamps
    end

    add_index :helloasso_order_items, :order_item_id, unique: true
  end
end
