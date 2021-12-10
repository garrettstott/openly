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
FactoryBot.define do

  factory :address do
    association :addressable, factory: :job_listing
    city { Faker::Address.city }
    country { Faker::Address.country }
    line1 { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    region { Faker::Address.state }
  end

end
