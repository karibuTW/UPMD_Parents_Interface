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
require 'rails_helper'

RSpec.describe DiscountCode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
