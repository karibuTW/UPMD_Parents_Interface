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
class HelloassoOrderItem < ApplicationRecord
  belongs_to :helloasso_order
  enum price_category: {
    Free: 0,
    Fixed: 1,
    "Pwyw": 2
  }

  enum order_item_type: {
    "Donation": 0,
    "Payment": 1,
    "Registration": 2,
    "Membership": 3,
    "MonthlyDonation": 4,
    "MonthlyPayment": 5,
    "OfflineDonation": 6,
    "Contribution": 7,
    "Bonus": 8
  }

  enum state: {
    "Waiting": 0,
    "Processed": 1,
    "Registered": 2,
    "Deleted": 3,
    "Refunded": 4,
    "Unknown": 5,
    "Canceled": 6,
    "Contested": 7
  }

  validates :helloasso_order_id, presence: true
  validates :amount, presence: true

  validates :order_item_id, uniqueness: true
end
