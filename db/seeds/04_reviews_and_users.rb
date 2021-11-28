Company.find_each do |company|
  puts "Creating Reviews/Users For: #{company.name}"
  # Create reviews for Uber
  user = User.first
  r = Review.new(
    user: user,
    company: company,
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)),
    approved: [true, false].sample,
    thumbs: Faker::Number.between(from: 1, to: 400),
  )
  r.save
  120.times do |i|
    first_name = Faker::Name.first_name
    last_name =Faker::Name.last_name
    user = User.create(
      first_name: first_name,
      last_name: last_name,
      gender: Faker::Demographic.sex,
      person_of_color: [true, false].sample,
      race: Faker::Demographic.race,
      orientation: Faker::Gender.type,
      email: "#{first_name}.#{last_name}@test.com",
      password: 'Testtest123!',
      confirmed_at: DateTime.now
    )
    if user.save
      user.add_employment(
        company,
        DateTime.now - rand(1..45).years - rand(30..90).days,
        true,
        Faker::Company.profession,
        Faker::Number.between(from: 12000, to: 140000)
      )
    else
      puts user.errors.messages
      next
    end
    r = Review.new(
      user: user,
      company: company,
      message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)),
      approved: [true, false].sample,
      thumbs: Faker::Number.between(from: 1, to: 400),
    )
    unless r.save
      puts r.errors.full_messages.to_sentence
    end
    company.chiefs.each do |chief|
      r2 = Review.new(
        user: user,
        company: company,
        chief: chief,
        message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)),
        approved: [true, false].sample,
        thumbs: Faker::Number.between(from: 1, to: 400),
      )
      unless r2.save
        puts r.errors.full_messages.to_sentence
      end
    end
  end
end
