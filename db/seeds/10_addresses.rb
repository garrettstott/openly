Company.find_each do |company|
  puts "Creating Address For: #{company.name}"
  address = company.addresses.new(
    line1: Faker::Address.street_address,
    line2: [true, false].sample ? Faker::Address.secondary_address : nil,
    city: Faker::Address.city,
    region: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.postcode
  )
  unless address.save
    puts address.errors.full_messages.to_sentence
  end
end
