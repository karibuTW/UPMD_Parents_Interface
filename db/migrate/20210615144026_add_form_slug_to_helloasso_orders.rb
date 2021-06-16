class AddFormSlugToHelloassoOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :helloasso_orders, :form_slug, :string, null: false
  end
end
