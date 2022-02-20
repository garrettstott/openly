Company.find_each do |company|
  puts "Creating Reviews For: #{company.name}"
  # Create reviews for Uber
  uber = User.first
  r = Review.new(
    user: uber,
    company: company,
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)),
    approved: [true, false].sample,
    thumbs: Faker::Number.between(from: 1, to: 400),
  )
  unless r.save
    puts r.errors.full_messages.to_sentence
  end

  User.find_each do |user|
    r = Review.new(
      user: user,
      company: company,
      message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)),
      approved: [true, true, false].sample,
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
        approved: [true, true, false].sample,
        thumbs: Faker::Number.between(from: 1, to: 400),
        )
      unless r2.save
        puts r.errors.full_messages.to_sentence
      end
    end
  end
end
