class AddDiscountCodeToHelloassoOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :helloasso_orders, :discount_code
  end
end
