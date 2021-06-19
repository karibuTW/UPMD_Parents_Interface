# == Schema Information
#
# Table name: bus_drivers
#
#  id                     :bigint           not null, primary key
#  company_name           :string           not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_bus_drivers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_bus_drivers_on_email                 (email) UNIQUE
#  index_bus_drivers_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :bus_driver do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
