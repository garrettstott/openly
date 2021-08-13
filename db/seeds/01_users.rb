roles = %w(uber mod super)

roles.each do |role|
  puts "Create User With Role: #{role}"
  u = User.new(
    first_name: role,
    last_name: 'admin',
    gender: 'unknown',
    person_of_color: [true, false].sample,
    race: 'unknown',
    orientation: 'unknown',
    email: "#{role}@test.com",
    password: 'Testtest123!',
    admin: true,
    role: role,
    confirmed_at: DateTime.now,
  )
  unless u.save
    binding.pry
    puts u.errors.full_messages.to_sentence
  end
end
