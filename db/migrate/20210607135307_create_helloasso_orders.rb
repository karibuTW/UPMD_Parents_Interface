class CreateHelloassoOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :helloasso_orders do |t|
      t.belongs_to :parent
      t.decimal :amount_total
      t.decimal :amount_vat
      t.decimal :amount_discount
      t.string :helloasso_order_id
      t.datetime :date

      t.timestamps
    end

    add_index :helloasso_orders, :helloasso_order_id, unique: true
  end
end
