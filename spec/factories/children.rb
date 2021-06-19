# == Schema Information
#
# Table name: children
#
#  id             :bigint           not null, primary key
#  birth_date     :date             not null
#  first_name     :string           not null
#  full_name      :string           not null
#  grade          :integer          default("TPS")
#  last_name      :string           not null
#  public_comment :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :bigint           not null
#
# Indexes
#
#  index_children_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#
FactoryBot.define do
  factory :child do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    full_name { Faker::Name.name }
    birth_date { Faker::Date.birthday }
    grade { Faker::Number.between(from: 0, to: 15) }
    association :parent
  end
end
