Company.find_each do |company|
  puts "Creating Job Listings For :#{company.name}"
  10.times do |i|
    salary = Faker::Number.between(from: 12000, to: 140000)
    salary2 = salary + Faker::Number.between(from: 3000, to: 30000)
    job = company.job_listings.new(
      job_title: Faker::Company.profession,
      salary: "$#{salary} - $#{salary2}",
      description: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 20)),
      job_type: JobListing.job_types.keys.sample
    )
    if job.save
      job.addresses.create(
        line1: nil,
        line2: nil,
        city: Faker::Address.city,
        region: Faker::Address.state,
        country: Faker::Address.country,
        postal_code: Faker::Address.postcode
      )
    else
      puts job.errors.full_messages.to_sentence
    end
  end
end
