# == Schema Information
#
# Table name: bus_services
#
#  id         :bigint           not null, primary key
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint           not null
#
# Indexes
#
#  index_bus_services_on_parent_id           (parent_id)
#  index_bus_services_on_parent_id_and_year  (parent_id,year) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#
class BusService < ApplicationRecord
  belongs_to :parent
  validates :year, uniqueness: { scope: :parent }
  def initialize(attributes = nil)
    super
    self.year = Setting.current_school_year_start
  end
end
