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
#  nationalities      :string           default([]), is an Array
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
require 'rails_helper'

RSpec.describe SecondaryParent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
