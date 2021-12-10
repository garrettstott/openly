Review.where(denied: true).each do |review|
  review.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first
  )
  review.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: review.user
  )
end

Company.where(denied: true).each do |company|
  company.update(created_by: User.last(20).sample)
  company.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first
  )
  company.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: company.created_by
  )
end

Chief.where(denied: true).each do |chief|
  chief.update(created_by: User.last(20).sample)
  chief.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first
  )
  chief.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: chief.created_by
  )
end
