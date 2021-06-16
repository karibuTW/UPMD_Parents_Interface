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
FactoryBot.define do
  factory :discount_code do
    code { "MyString" }
    owner { "MyString" }
    status { 1 }
  end
end
