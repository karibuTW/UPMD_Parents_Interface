# == Schema Information
#
# Table name: helloasso_payments
#
#  id                   :bigint           not null, primary key
#  amount               :decimal(, )
#  amount_tip           :decimal(, )
#  cash_out_state       :integer          default("MoneyIn")
#  date                 :datetime
#  fiscal_receipt_url   :string
#  payment_means        :integer          default("None")
#  payment_receipt_url  :string
#  payment_type         :integer          default("OFFLINE")
#  state                :integer          default("Pending")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  helloasso_order_id   :bigint           not null
#  helloasso_payment_id :string
#
# Indexes
#
#  index_helloasso_payments_on_helloasso_order_id    (helloasso_order_id)
#  index_helloasso_payments_on_helloasso_payment_id  (helloasso_payment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (helloasso_order_id => helloasso_orders.id)
#
FactoryBot.define do
  factory :helloasso_payment do
    helloasso_order { nil }
    amount_tip { "9.99" }
    cash_out_state { 1 }
    payment_receipt_url { "MyString" }
    fiscal_receipt_url { "MyString" }
    helloasso_payment_id { "MyString" }
    amount { "9.99" }
    date { "2021-06-07 19:26:49" }
    payment_means { 1 }
    state { 1 }
    type { 1 }
  end
end
