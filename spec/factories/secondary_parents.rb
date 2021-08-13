# == Schema Information
#
# Table name: secondary_parents
#
#  id                 :bigint           not null, primary key
#  address            :string           not null
#  email              :string           not null
#  first_name         :string           not null
#  full_name          :string           not null
#  last_name          :string           not null
#  nationalities      :string           default([]), is an Array
#  phone_number       :string           not null
#  preferred_language :integer          default("en"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_id          :bigint           not null
#
# Indexes
#
#  index_secondary_parents_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#
FactoryBot.define do
  factory :secondary_parent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    full_name { Faker::Name.name }
    phone_number { "+33627899541" }
    address { Faker::Address.full_address }
    preferred_language { 1 }
    email { Faker::Internet.email }

    association :parent
  end
end
