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
require 'rails_helper'

RSpec.describe Rating, type: :model do

  context 'Validates correctly' do
    let :rating do
      build(:rating)
    end
    it 'is valid from factory' do
      expect(rating.valid?).to eq(true)
    end
    it 'returns no errors' do
      rating.valid?
      expect(rating.errors.full_messages).to eq([])
    end
  end

end
