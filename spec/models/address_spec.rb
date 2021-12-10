# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string(255)      not null
#  city             :string(255)      not null
#  country          :string(255)      not null
#  line1            :string(255)
#  line2            :string(255)
#  postal_code      :string(255)      not null
#  region           :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :integer          not null
#
# Indexes
#
#  index_addresses_on_addressable_id    (addressable_id)
#  index_addresses_on_addressable_type  (addressable_type)
#
require 'rails_helper'

RSpec.describe Address, type: :model do

  context 'Validates correctly' do
    let :address do
      build(:address)
    end
    it 'is valid from factory' do
      expect(address.valid?).to eq(true)
    end
    it 'returns no errors' do
      address.valid?
      expect(address.errors.full_messages).to eq([])
    end
  end

end
