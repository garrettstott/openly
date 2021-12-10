Company.find_each do |company|
  titles = Chief.titles.keys
  titles.each do |title|
    chief = Chief.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      title: title,
      company: company,
      created_by: User.first
      )
    unless chief.save
      puts chief.errors.full_messages.to_sentence
    end
  end
end
