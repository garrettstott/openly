# == Schema Information
#
# Table name: employment_companies
#
#  id         :integer          not null, primary key
#  current    :boolean          default(TRUE), not null
#  end_date   :date
#  job_title  :string           not null
#  salary     :integer
#  start_date :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_employment_companies_on_company_id  (company_id)
#  index_employment_companies_on_user_id     (user_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#  user_id     (user_id => users.id)
#
class EmploymentCompany < ApplicationRecord

  include NiceDateable
  include Iconable

  belongs_to :user
  belongs_to :company

  validates_presence_of :start_date, :current, :job_title, :salary

  before_save :format_job_title, :format_salary

  def format_job_title
    self.job_title = self.job_title.titleize
  end

  def format_salary
    self.salary = self.salary.floor
  end
end
