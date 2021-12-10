# == Schema Information
#
# Table name: job_listings
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  job_title   :string(255)
#  job_type    :integer
#  salary      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
# Indexes
#
#  index_job_listings_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do

  factory :job_listing do
    salary = Faker::Number.between(from: 12000, to: 140000)
    salary2 = salary + Faker::Number.between(from: 3000, to: 30000)
    description { Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 1, to: 20)) }
    job_title { Faker::Company.profession }
    salary { "$#{salary} - $#{salary2}" }
    job_type { JobListing.job_types.keys.sample }
    company { create(:company) }
  end

end
