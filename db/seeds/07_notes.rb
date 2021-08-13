Review.where(denied: true).each do |review|
  review.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first.id
  )
  review.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: review.user_id
  )
end

Company.where(denied: true).each do |company|
  company.update(created_by: User.last(20).sample.id)
  company.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first.id
  )
  company.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: company.created_by
  )
end

Chief.where(denied: true).each do |chief|
  chief.update(created_by: User.last(20).sample.id)
  chief.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.first,
    created_by: User.first.id
  )
  chief.notes.create(
    message: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 10)),
    style: Note.styles.keys.second,
    created_by: chief.created_by
  )
end
