# == Schema Information
#
# Table name: reviews
#
#  id               :integer          not null, primary key
#  approved         :boolean          default(FALSE), not null
#  denied           :boolean          default(FALSE), not null
#  message          :text             not null
#  overall_rating   :float            default(0.0), not null
#  previous_message :text
#  thumbs           :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chief_id         :integer
#  company_id       :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_reviews_on_chief_id    (chief_id)
#  index_reviews_on_company_id  (company_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  chief_id    (chief_id => chiefs.id)
#  company_id  (company_id => companies.id)
#  user_id     (user_id => users.id)
#
class Review < ApplicationRecord

  extend Queueable

  include Rateable
  include Iconable
  include Noteable
  include NiceDateable

  belongs_to :user
  belongs_to :company
  belongs_to :chief, optional: true

  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :ratings

  validates_presence_of :company, :user, :message
  validates_inclusion_of :denied, :approved, in: [true, false]

  before_update :set_previous_message
  before_update :set_approvals

  def set_previous_message
    if self.will_save_change_to_message?
      self.previous_message = self.message_was
    end
  end

  def set_approvals
    if self.will_save_change_to_message?
      self.approved = false
      self.denied = false
    end
  end

  def short_message
    message[0..30].gsub(/\s\w+\s*$/, '...') rescue 'Empty Message'
  end

  def approved?
    self.approved ? 'Yes' : 'No'
  end

  def denied?
    self.denied ? 'Yes' : 'No'
  end

  def review_for
    string = ''
    if chief.present?
      string += "#{chief.full_name} (#{chief.title_small}) @ "
    end
    string += "#{company.name}"
  end

  def calculate_overall_score
    return unless ratings.count > 3
    scores = ratings.pluck(:score)
    self.overall_rating = (scores.inject{ |sum, el| sum + el }.to_f / scores.size).round(1)
    self.save
  end

  def edited?
    self.previous_message.present?
  end

end
