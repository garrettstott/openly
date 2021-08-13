# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  addressable_type :string           not null
#  city             :string           not null
#  country          :string           not null
#  line1            :string
#  line2            :string
#  postal_code      :string           not null
#  region           :string           not null
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
