# == Schema Information
#
# Table name: discount_codes
#
#  id         :bigint           not null, primary key
#  code       :string
#  owner      :string
#  status     :integer          default("activated")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_discount_codes_on_code  (code) UNIQUE
#
class DiscountCode < ApplicationRecord
  has_many :helloasso_orders, inverse_of: :discount_code
  enum status: {
    activated: 0,
    deactivated: 1
  }

  def display_name
    code
  end
end
