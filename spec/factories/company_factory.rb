# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  about          :text(65535)
#  approved       :boolean          default(FALSE), not null
#  denied         :boolean          default(FALSE), not null
#  employee_count :integer
#  founded        :integer
#  industry       :string(255)
#  name           :string(255)      not null
#  website        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by_id  :integer          not null
#
# Indexes
#
#  index_companies_on_created_by_id  (created_by_id)
#
FactoryBot.define do

  factory :company do
    name = Faker::Company.name
    name { name }
    created_by { create(:user) }
    industry { Faker::Company.industry }
    about { Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 20)) }
    founded { Faker::Number.between(from: 1820, to: 2021) }
    website { "https://www.#{name.downcase}.com" }
    employee_count { Company.employee_counts_for_forms.sample.first }
    approved { true }
  end

end
