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
#  year               :integer          default(2021), not null
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
FactoryBot.define do
  factory :helloasso_order do
    parent { "" }
    amount_total { "9.99" }
    amount_vat { "9.99" }
    amount_discount { "9.99" }
    helloasso_order_id { "MyString" }
    date { "2021-06-07 19:23:07" }
  end
end
