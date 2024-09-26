# == Schema Information
#
# Table name: parents
#
#  id                     :bigint           not null, primary key
#  address                :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  full_name              :string
#  last_name              :string           not null
#  mailing_list           :boolean          default(TRUE), not null
#  nationalities          :string           default([]), is an Array
#  phone_number           :string
#  preferred_language     :integer          default("vi"), not null
#  public_comment         :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  moosend_id             :string
#
# Indexes
#
#  index_parents_on_confirmation_token    (confirmation_token) UNIQUE
#  index_parents_on_email                 (email) UNIQUE
#  index_parents_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :parent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    full_name { Faker::Name.name }
    address { Faker::Address.full_address }
    phone_number { "+911234567890" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
