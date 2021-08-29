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
