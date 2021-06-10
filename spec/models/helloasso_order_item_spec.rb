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
require 'rails_helper'

RSpec.describe HelloassoOrderItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
