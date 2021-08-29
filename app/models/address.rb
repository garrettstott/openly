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
class Address < ApplicationRecord

  validates_presence_of :city, :region, :country, :postal_code


  def short_address
    "#{self.city}, #{self.region} #{self.country}"
  end
end
