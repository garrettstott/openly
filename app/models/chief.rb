# == Schema Information
#
# Table name: chiefs
#
#  id         :bigint           not null, primary key
#  approved   :boolean          default(FALSE), not null
#  created_by :integer          not null
#  current    :boolean          default(TRUE), not null
#  denied     :boolean          default(FALSE), not null
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  title      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_chiefs_on_company_id  (company_id)
#  index_chiefs_on_created_by  (created_by)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Chief < ApplicationRecord

  include Rateable
  include Iconable
  include Noteable
  extend Queueable

  belongs_to :company

  has_many :reviews

  validates :title, uniqueness: {scope: :company_id}
  validates_presence_of :first_name, :last_name, :created_by
  validates_inclusion_of :denied, :approved, in: [true, false]

  enum title: {chief_executive_officer: 0, chief_technology_officer: 1, chief_operating_officer: 2, chief_financial_officer: 3, chief_marketing_officer: 4, chief_human_resources_officer: 5}

  def title_nice
    title.titleize
  end

  def title_small
    title.humanize.split.map(&:first).join.upcase
  end

  def self.titles_for_forms
    self.titles.keys.map { |t| [t.titleize, t] }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def ratings
    Rating.joins(:review).where(review: {approved: true, company_id: self.company_id, chief_id: self.id})
  end

  def approved_reviews
    self.reviews.where(approved: true)
  end

end
