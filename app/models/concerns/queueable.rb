module Queueable

  def get_queue_items
    case self.name
    when 'Company'
      items = Company.where(approved: false, denied: false).order(:created_at)
    when 'Chief'
      items = Chief.where(approved: false, denied: false).order(:created_at)
    when 'User'
      # TODO marking a review as inappropriate
      items = User.first(10)
    when 'Review'
      items = Review.where(approved: false, denied: false).order(:created_at)
    else
      raise 'Queueable: class not found'
    end
    items
  end

end
