# == Schema Information
#
# Table name: companies
#
#  id             :integer          not null, primary key
#  about          :text
#  approved       :boolean          default(FALSE), not null
#  created_by     :integer          not null
#  denied         :boolean          default(FALSE), not null
#  employee_count :string
#  founded        :integer
#  industry       :string
#  name           :string           not null
#  website        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_companies_on_created_by  (created_by)
#
class Company < ApplicationRecord

  include Rateable
  include Iconable
  include Noteable
  include Addressable
  extend Queueable

  validates_presence_of :name, :created_by
  validates_inclusion_of :denied, :approved, in: [true, false]
  validates_uniqueness_of :name

  has_many :job_listings
  has_many :reviews
  has_many :chiefs
  has_many :employment_companies
  has_many :users, through: :employment_companies

  def ratings
    Rating.joins(:review).where(review: {approved: true, company_id: self.id, chief_id: nil})
  end

  def approved_reviews
    self.reviews.where(approved: true, chief_id: nil)
  end

  def approved_current_chiefs
    self.chiefs.where(approved: true, current: true).order(title: :asc)
  end

  def location
    self.addresses.first.short_address
  end

end
