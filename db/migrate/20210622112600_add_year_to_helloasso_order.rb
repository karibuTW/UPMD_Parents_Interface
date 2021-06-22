class AddYearToHelloassoOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :helloasso_orders, :year, :integer, default: 2021, null: false
  end
end
