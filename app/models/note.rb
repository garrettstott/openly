# == Schema Information
#
# Table name: notes
#
#  id            :bigint           not null, primary key
#  created_by    :integer          not null
#  message       :text(65535)
#  noteable_type :string(255)
#  style         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  noteable_id   :integer
#
# Indexes
#
#  index_notes_on_created_by     (created_by)
#  index_notes_on_noteable_id    (noteable_id)
#  index_notes_on_noteable_type  (noteable_type)
#
class Note < ApplicationRecord

  include NiceDateable

  belongs_to :noteable, polymorphic: true

  validates_presence_of :message, :style, :created_by

  enum style: { denial_reason: 0, response: 1, general: 2, review_message: 3 }

  def self.styles_for_forms
    self.styles.keys.map { |s| [s.titleize, s] }
  end

  def created_by_user
    user = User.find_by(id: self.created_by)
    return 'Not Found' unless user.present?
    if user.admin
      "#{APPLICATION_NAME} Admin"
    elsif user.respond_to?(:username)
      user.username
    end
  end

end
