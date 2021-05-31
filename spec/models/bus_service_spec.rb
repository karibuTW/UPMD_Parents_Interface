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
require 'rails_helper'

RSpec.describe BusService, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
