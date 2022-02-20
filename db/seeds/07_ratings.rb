puts 'Rating All The Things...'
Review.find_each do |review|
  Rating.styles.keys.each do |style|
    r = Rating.new(
      review: review,
      style: style,
      score: Faker::Number.between(from: 0, to: 5),
    )
    unless r.save
      puts r.errors.full_messages.to_sentence
    end
  end
end
