# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  about          :text(65535)
#  approved       :boolean          default(FALSE), not null
#  created_by     :integer          not null
#  denied         :boolean          default(FALSE), not null
#  employee_count :integer
#  founded        :integer
#  industry       :string(255)
#  name           :string(255)      not null
#  website        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_companies_on_created_by  (created_by)
#
class Company < ApplicationRecord

  include Darwinable
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

  enum employee_count: {"0-10": 0, "10-50": 1, "50-100": 2, "100-500": 3, "500-1000": 4, "1000-5000": 5, "5000+": 6}

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
    if self.addresses.any?
      self.addresses.first.short_address
    else
      ''
    end
  end

  def self.employee_counts_for_forms
    self.employee_counts.keys.map { |t| [t, t] }
  end

end
