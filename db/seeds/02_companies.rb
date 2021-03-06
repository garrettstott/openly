names = %w(Verisys Adobe)
10.times.each do |i|
  name = Faker::Company.name
  puts "Create Company: #{name}"
  c = Company.new(
    name: name,
    created_by: User.first.id,
    industry: Faker::Company.industry,
    about: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 20)),
    founded: Faker::Number.between(from: 1820, to: 2021),
    website: "https://www.#{name.downcase.parameterize}.com",
    employee_count: Faker::Number.between(from: 1, to: 50000),
  )
  if c.save
    User.first.add_employment(
      c,
      DateTime.now - rand(1..45).years - rand(30..90).days,
      true,
      Faker::Company.profession,
      Faker::Number.between(from: 12000, to: 140000)
    )
  else
    puts c.errors.full_messages.to_sentence
  end
end
names.each do |name|
  puts "Create Company: #{name}"
  c = Company.new(
    name: name,
    created_by: User.first.id,
    industry: Faker::Company.industry,
    about: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 20)),
    founded: Faker::Number.between(from: 1820, to: 2021),
    website: "https://www.#{name.downcase}.com",
    employee_count: Faker::Number.between(from: 1, to: 50000),
  )
  if c.save
    User.first.add_employment(
      c,
      DateTime.now - rand(1..45).years - rand(30..90).days,
      true,
      Faker::Company.profession,
      Faker::Number.between(from: 12000, to: 140000)
    )
  else
    puts c.errors.full_messages.to_sentence
  end
end
