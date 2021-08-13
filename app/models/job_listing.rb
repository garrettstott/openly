# == Schema Information
#
# Table name: job_listings
#
#  id          :integer          not null, primary key
#  description :text
#  job_title   :string
#  job_type    :integer
#  salary      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer          not null
#
# Indexes
#
#  index_job_listings_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
class JobListing < ApplicationRecord

  include Addressable

  belongs_to :company

  enum job_type: {full_time: 0, part_time: 1, seasonal: 2}

  before_save :format_job_title

  def format_job_title
    self.job_title = self.job_title.titleize
  end

  def job_type_nice
    self.job_type.titleize
  end

  def location
    self.addresses.last.short_address
  end
end
