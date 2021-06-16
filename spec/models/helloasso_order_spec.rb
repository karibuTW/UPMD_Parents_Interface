# == Schema Information
#
# Table name: helloasso_orders
#
#  id                 :bigint           not null, primary key
#  amount_discount    :decimal(, )
#  amount_total       :decimal(, )
#  amount_vat         :decimal(, )
#  confirmation       :integer          default("automatic")
#  date               :datetime
#  form_slug          :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discount_code_id   :bigint
#  helloasso_order_id :string
#  parent_id          :bigint
#
# Indexes
#
#  index_helloasso_orders_on_discount_code_id    (discount_code_id)
#  index_helloasso_orders_on_helloasso_order_id  (helloasso_order_id) UNIQUE
#  index_helloasso_orders_on_parent_id           (parent_id)
#
require 'rails_helper'

RSpec.describe HelloassoOrder, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
