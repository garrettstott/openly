35.times do
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
  unless user.save
    puts user.errors.messages
  end
end
