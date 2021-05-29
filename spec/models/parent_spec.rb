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
require "rails_helper"

RSpec.describe Parent, type: :model do
  describe "validation of required fields" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone_number) }
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
    it { should belong_to(:primary_parent).without_validating_presence }
    it { should have_one(:secondary_parent).with_foreign_key(:primary_parent_id)}

    it "should set up associations" do
      @parent1 = create(:parent, phone_number: "+33627899541")
      @parent2 = create(:parent, phone_number: "+33627899541", primary_parent: @parent1)

      expect(@parent2.primary_parent).to eq(@parent1)
      expect(@parent1.secondary_parent).to eq(@parent2)
    end

  end
end
