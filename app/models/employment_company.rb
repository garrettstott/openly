# == Schema Information
#
# Table name: employment_companies
#
#  id         :bigint           not null, primary key
#  current    :boolean          default(TRUE), not null
#  end_date   :date
#  job_title  :string(255)      not null
#  salary     :integer
#  start_date :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_employment_companies_on_company_id  (company_id)
#  index_employment_companies_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
class EmploymentCompany < ApplicationRecord

  include NiceDateable
  include Iconable

  belongs_to :user
  belongs_to :company

  validates_presence_of :start_date, :job_title, :salary
  validates_inclusion_of :current, in: [true, false]

  before_save :format_job_title, :format_salary

  def format_job_title
    self.job_title = self.job_title.titleize
  end

  def format_salary
    self.salary = self.salary.floor
  end
end
