class AddConfirmationToHelloassoOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :helloasso_orders, :confirmation, :integer, default: 0
  end
end
