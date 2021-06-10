# == Schema Information
#
# Table name: helloasso_orders
#
#  id                 :bigint           not null, primary key
#  amount_discount    :decimal(, )
#  amount_total       :decimal(, )
#  amount_vat         :decimal(, )
#  date               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  helloasso_order_id :string
#  parent_id          :bigint
#
# Indexes
#
#  index_helloasso_orders_on_helloasso_order_id  (helloasso_order_id) UNIQUE
#  index_helloasso_orders_on_parent_id           (parent_id)
#
class HelloassoOrder < ApplicationRecord
  belongs_to :parent
  has_many :helloasso_order_items
  has_many :helloasso_payments

  validates :helloasso_order_id, uniqueness: true
end
