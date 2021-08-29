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
class Rating < ApplicationRecord

  belongs_to :review

  validates_presence_of :review, :score, :style

  enum style: {culture: 0, diversity: 1, integrity: 2, respect: 3, salary: 4, benefits: 5}

  after_save :calculate_review_score

  def calculate_review_score
    self.review.calculate_overall_score
  end

end
