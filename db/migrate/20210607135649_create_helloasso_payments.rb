class CreateHelloassoPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :helloasso_payments do |t|
      t.references :helloasso_order, null: false, foreign_key: true
      t.decimal :amount_tip
      t.integer :cash_out_state, default: 0
      t.string :payment_receipt_url
      t.string :fiscal_receipt_url
      t.string :helloasso_payment_id
      t.decimal :amount
      t.datetime :date
      t.integer :payment_means, default: 0
      t.integer :state, default: 0
      t.integer :payment_type, default: 0

      t.timestamps
    end

    add_index :helloasso_payments, :helloasso_payment_id, unique: true
  end
end
