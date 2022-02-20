Company.find_each do |company|
  User.find_each do |user|
    start_date = DateTime.now - rand(1..23).years - rand(30..90).days
    end_date = nil
    current = true
    if user.employment_companies.where(current: true).any?
      adjusted = ((((DateTime.now - start_date) * 24 * 60 * 60).to_i) / 86400) / [2,5,10].sample
      current = false
      end_date = DateTime.now - adjusted.days
    end
    employment = user.add_employment(
      company,
      start_date,
      current,
      Faker::Company.profession,
      Faker::Number.between(from: 12000, to: 140000),
      end_date
    )
    unless employment.persisted?
      puts employment.errors.full_messages.to_s
    end
  end
end
