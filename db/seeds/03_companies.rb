names = %w(Verisys Adobe Microsoft Amazon Twitter Starbucks HBO Netflix)
names.each do |name|
  puts "Create Company: #{name}"
  c = Company.new(
    name: name,
    created_by: User.first,
    industry: Faker::Company.industry,
    about: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 20)),
    founded: Faker::Number.between(from: 1820, to: 2021),
    website: "https://www.#{name.downcase}.com",
    employee_count: Company.employee_counts_for_forms.sample.first,
    approved: true
  )
  unless c.save
    puts c.errors.full_messages.to_sentence
  end
end
