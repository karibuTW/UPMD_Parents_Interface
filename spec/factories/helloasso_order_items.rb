# == Schema Information
#
# Table name: helloasso_order_items
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  cancelled           :boolean          default(FALSE)
#  date                :datetime
#  discount_amount     :decimal(, )
#  discount_code       :string
#  membership_card_url :string
#  order_item_type     :integer          default("Donation")
#  price_category      :integer          default("Free")
#  state               :integer          default("Waiting")
#  ticket_url          :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  helloasso_order_id  :bigint           not null
#  order_item_id       :string
#
# Indexes
#
#  index_helloasso_order_items_on_helloasso_order_id  (helloasso_order_id)
#  index_helloasso_order_items_on_order_item_id       (order_item_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (helloasso_order_id => helloasso_orders.id)
#
FactoryBot.define do
  factory :helloasso_order_item do
    helloasso_order { "" }
    order_item_id { "MyString" }
    date { "2021-06-07 19:24:05" }
    amount { "" }
    cancelled { false }
    type { 1 }
    state { 1 }
    ticket_url { "MyString" }
    membership_card_url { "MyString" }
    price_category { 1 }
  end
end
