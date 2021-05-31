# == Schema Information
#
# Table name: bus_services
#
#  id         :bigint           not null, primary key
#  year       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint           not null
#
# Indexes
#
#  index_bus_services_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#
class BusService < ApplicationRecord
  belongs_to :parent

  def initialize(attributes = nil)
    super
    self.year = Setting.bus_registration_year
  end
end
