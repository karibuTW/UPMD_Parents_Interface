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
  describe 'validations' do
    it { should validate_presence_of(:owner) }
    it { should validate_presence_of(:code) }
  end
end
