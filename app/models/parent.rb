# == Schema Information
#
# Table name: parents
#
#  id                     :bigint           not null, primary key
#  address                :string           not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  full_name              :string           not null
#  last_name              :string           not null
#  mailing_list           :boolean          default(TRUE), not null
#  phone_number           :string           not null
#  preferred_language     :integer          default("english"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  primary_parent_id      :bigint
#
# Indexes
#
#  index_parents_on_confirmation_token    (confirmation_token) UNIQUE
#  index_parents_on_email                 (email) UNIQUE
#  index_parents_on_primary_parent_id     (primary_parent_id)
#  index_parents_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (primary_parent_id => parents.id)
#
class Parent < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_plausible_phone :phone_number, presence: true, with: /\A\+\d+/

  phony_normalize :phone_number, normalize_when_valid: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :full_name, presence: true
  validates :address, presence: true

  enum preferred_language: {
    english: 0,
    french: 1,
    vietnamese: 2
  }

  has_one :secondary_parent, class_name: "Parent", foreign_key: "primary_parent_id"
  belongs_to :primary_parent, class_name: "Parent", optional: true

  has_many :children
end
