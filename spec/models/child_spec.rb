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
require 'rails_helper'

RSpec.describe Child, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:birth_date) }
  end
end
