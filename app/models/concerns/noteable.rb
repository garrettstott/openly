module Noteable
  extend ActiveSupport::Concern

  included do
    has_many :notes, as: :noteable
    accepts_nested_attributes_for :notes
  end

  def created_by_user
    User.find_by(id: self.try(:created_by))
  end
end
