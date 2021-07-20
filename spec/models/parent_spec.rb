# == Schema Information
#
# Table name: parents
#
#  id                     :bigint           not null, primary key
#  address                :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  full_name              :string
#  last_name              :string           not null
#  mailing_list           :boolean          default(TRUE), not null
#  phone_number           :string
#  preferred_language     :integer          default("vi"), not null
#  public_comment         :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_parents_on_confirmation_token    (confirmation_token) UNIQUE
#  index_parents_on_email                 (email) UNIQUE
#  index_parents_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe Parent, type: :model do
  describe "validation of required fields" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

  end

  describe "validates phone with country code" do
    subject { build(:parent, phone_number: "+33627899541") }

    it { should be_valid }
  end

  describe "should invalidate phone without country code" do
    subject { build(:parent, phone_number: "627899541") }

    it { should_not be_valid }
  end

  describe "should invalidate invalid number" do
    subject { build(:parent, phone_number: "asfafca") }

    it { should_not be_valid }
  end

  describe "associations" do

    it { should have_one(:secondary_parent)}

    it "should set up associations" do
      @parent1 = create(:parent, phone_number: "+33627899541")
      @parent2 = create(:secondary_parent, parent: @parent1)

      expect(@parent2.parent).to eq(@parent1)
      expect(@parent1.secondary_parent).to eq(@parent2)
    end

  end

  describe "bus registration" do
    it 'should know when new bus registration done' do
      @parent = create(:parent)
      @bus = create(:bus_service, parent: @parent)


      expect(@parent.renewed_bus_service?).to eq(false)
      expect(@parent.new_bus_service?).to eq(true)
    end

    it 'should know when bus registration renewed' do
      @parent = create(:parent)
      @bus = create(:bus_service, parent: @parent)

      Setting.current_school_year_start = Time.now.year + 1
      @bus2 = create(:bus_service, year: Setting.current_school_year_start, parent: @parent)

      expect(@parent.renewed_bus_service?).to eq(true)
      expect(@parent.new_bus_service?).to eq(false)
    end
  end
end
