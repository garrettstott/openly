# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  score      :integer          default(0), not null
#  style      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :bigint           not null
#
# Indexes
#
#  index_ratings_on_review_id  (review_id)
#
# Foreign Keys
#
#  fk_rails_...  (review_id => reviews.id)
#
FactoryBot.define do

  factory :rating do
    review { create(:review) }
    style { Rating.styles.keys.sample }
    score { Faker::Number.between(from: 1, to: 5) }
  end

end
