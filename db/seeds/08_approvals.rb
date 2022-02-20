puts 'Approving...'
def decide(object)
  approved = [true, false].sample
  object.update(approved: approved)
  if approved == false
    denied = [true, false].sample
    object.update(denied: denied)
  end
end

# Company.find_each do |company|
#   decide(company)
# end

Review.find_each do |review|
  decide(review)
end

Chief.find_each do |chief|
  decide(chief)
end
