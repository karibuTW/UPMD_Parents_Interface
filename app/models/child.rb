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

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def unaccompanied?
    age >= 12
  end
end
