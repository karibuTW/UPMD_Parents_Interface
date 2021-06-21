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
require 'rails_helper'

RSpec.describe BusService, type: :model do
  describe "validations" do
    it 'should not allow parent for more than one registration' do
      @parent = create(:parent)
      @bus1 = create(:bus_service, parent: @parent)
      @bus2 = build(:bus_service, parent: @parent)
      expect(@bus2).to be_invalid
    end
  end
end
