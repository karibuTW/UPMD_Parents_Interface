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
#  previous_grade :integer          default("None")
#  public_comment :text
#  taking_bus     :boolean          default(FALSE)
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
class Child < ApplicationRecord
  belongs_to :parent

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validates :full_name, presence: true

  scope :unaccompanied, -> { where("date_part('year', age(birth_date)) >= 12") }

  ransacker :age, type: :numeric do
    Arel.sql("date_part('year', age(birth_date))")
  end
  delegate :secondary_parent, to: :parent
  enum grade: {
    TPS: 0,
    PS: 1,
    MS: 2,
    GS: 3,
    CP: 4,
    CE1: 5,
    CE2: 6,
    CM1: 7,
    CM2: 8,
    "6e": 9,
    "5e": 10,
    "4e": 11,
    "3e": 12,
    "2nd": 13,
    "1ere": 14,
    Term: 15
  }

  enum previous_grade: {
    None: -1,
    TPS: 0,
    PS: 1,
    MS: 2,
    GS: 3,
    CP: 4,
    CE1: 5,
    CE2: 6,
    CM1: 7,
    CM2: 8,
    "6e": 9,
    "5e": 10,
    "4e": 11,
    "3e": 12,
    "2nd": 13,
    "1ere": 14,
    Term: 15
  }, _prefix: true

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def unaccompanied?
    age >= 12
  end

  def to_csv
    csv_row = []
    csv_row << created_at
    csv_row << updated_at
    csv_row << (parent.has_current_bus_registration? ? 'Y' : 'N')
    csv_row << (parent.renewed_bus_service? ? 'Renew' : 'New')
    csv_row << id
    csv_row << first_name
    csv_row << last_name
    csv_row << full_name
    csv_row << birth_date
    csv_row << age
    csv_row << (unaccompanied? ? 'Y':'N')
    csv_row << grade

    csv_row << parent.first_name
    csv_row << parent.last_name
    csv_row << parent.full_name
    csv_row << parent.preferred_language
    csv_row << parent.email
    csv_row << parent.phone_number
    csv_row << parent.address

    csv_row << secondary_parent&.first_name
    csv_row << secondary_parent&.last_name
    csv_row << secondary_parent&.full_name
    csv_row << secondary_parent&.preferred_language
    csv_row << secondary_parent&.email
    csv_row << secondary_parent&.phone_number
    csv_row << secondary_parent&.address

    end

  def to_bus_csv
    csv_row = []

    # SBS
    8.times do
      csv_row << nil
    end
    csv_row << (parent.paid_member? ? parent.current_year_helloasso_order&.date : nil )
    csv_row << (parent.paid_member? ? parent.current_year_helloasso_order&.helloasso_id : nil )
    csv_row << (parent.paid_member? ? "Paid" : "Not paid")
    csv_row << nil
    csv_row << (parent.renewed_bus_service? ? 'Renew' : 'New')
    csv_row << id
    csv_row << nil
    csv_row << first_name
    csv_row << last_name
    csv_row << full_name
    csv_row << birth_date
    csv_row << age
    csv_row << (unaccompanied? ? 'Y':'N')
    csv_row << nil
    csv_row << grade
    csv_row << nil
    csv_row << public_comment
    15.times do
      csv_row << nil
    end
    csv_row << parent.id
    csv_row << nil
    csv_row << parent.first_name
    csv_row << parent.last_name
    csv_row << parent.full_name
    csv_row << parent.preferred_language
    csv_row << parent.email
    csv_row << parent.phone_number
    csv_row << parent.address

    csv_row << secondary_parent&.id
    csv_row << nil
    csv_row << secondary_parent&.first_name
    csv_row << secondary_parent&.last_name
    csv_row << secondary_parent&.full_name
    csv_row << secondary_parent&.preferred_language
    csv_row << secondary_parent&.email
    csv_row << secondary_parent&.phone_number
    csv_row << secondary_parent&.address

    3.times do
      csv_row << nil
    end

    csv_row
  end
end
