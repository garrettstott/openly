# == Schema Information
#
# Table name: chiefs
#
#  id            :bigint           not null, primary key
#  approved      :boolean          default(FALSE), not null
#  current       :boolean          default(TRUE), not null
#  denied        :boolean          default(FALSE), not null
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  title         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :bigint           not null
#  created_by_id :integer          not null
#
# Indexes
#
#  index_chiefs_on_company_id     (company_id)
#  index_chiefs_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do

  factory :chief do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { Chief.titles.keys.sample }
    company { association(:company) }
    created_by { create(:user) }
  end

end
