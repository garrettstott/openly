# == Schema Information
#
# Table name: reviews
#
#  id             :bigint           not null, primary key
#  approved       :boolean          default(FALSE), not null
#  denied         :boolean          default(FALSE), not null
#  message        :text(65535)      not null
#  overall_rating :float(24)        default(0.0), not null
#  thumbs         :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  chief_id       :bigint
#  company_id     :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_reviews_on_chief_id    (chief_id)
#  index_reviews_on_company_id  (company_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chief_id => chiefs.id)
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do

  factory :review do
    user { create(:user) }
    company { create(:company) }
    message { Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 100)) }
    approved { [true, false].sample }
    thumbs { Faker::Number.between(from: 1, to: 400) }
  end

end
