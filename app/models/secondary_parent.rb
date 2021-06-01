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
class SecondaryParent < ApplicationRecord
  belongs_to :parent

  include ParentCsvGenerator

  validates_plausible_phone :phone_number, presence: true, with: /\A\+\d+/

  phony_normalize :phone_number, normalize_when_valid: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :full_name, presence: true
  validates :address, presence: true

  enum preferred_language: {
    en: 0,
    fr: 1,
    vi: 2
  }

  delegate :children, to: :parent
  delegate :bus_services, to: :parent
  delegate :current_bus_registration, to: :parent
  delegate :previous_bus_registration, to: :parent
  delegate :has_current_bus_registration?, to: :parent
  delegate :has_previous_bus_registration?, to: :parent
  delegate :renewed_bus_service?, to: :parent
  delegate :new_bus_service?, to: :parent
end
