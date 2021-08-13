module
Rateable
  extend ActiveSupport::Concern

  def calculate_rating
    calculate_all_ratings_by_style
  end

  def stars(style: nil, num: nil)
    array = []
    num = get_rating(style: style) unless num
    num.ceil.times do |i|
      array.push("<i class='fas fa-star'></i>")
    end
    array.join('').html_safe
  end

  def get_rating(style: nil)
    num = 0
    if %w(Company Chief).include?(self.class.to_s)
      num = get_rating_by_style(style)
    elsif self.class == Review
      num = self.ratings.where(style: style).last.score rescue 0
    end
    num
  end

  def starso(style: 'none')
    array = []
    5.times do |i|
      array.push("<i data-value=#{i+1} data-type=#{style} class='far fa-star'></i>")
    end
    array.join('').html_safe
  end

  def star_width(style: nil, num: nil)
    num = get_rating(style: style) unless num
    num = num.to_f
    return num if num == 0.0
    width = (((num/5)*100))
    remainder = (num - num.floor).round(1)
    case remainder
    when 0.9
      width -= 4
    when 0.8
      width -= 4.5
    when 0.7
      width -= 2.4
    when 0.6
      width -= 1.3
    when 0.5
      width += 0.2
    when 0.4
      width += 1.5
    when 0.3
      width += 3
    when 0.2
      width += 4
    when 0.1
      width += 5
    else
      width += 0
    end
    width.round(2)
  end

  # TODO cache this
  def get_rating_by_style(style)
    all = self.ratings.where(style: style).pluck(:score)
    calculate_average(all)
  end

  # TODO cache this
  def review_count
    self.reviews.count
  end

  private

  def calculate_all_ratings_by_style
    Rating.styles.keys.each do |style|
      ratings = self.ratings.select { |r| r.style == style }.map { |r| r.score }
      return 0 if ratings.empty?
      calculate_average(ratings)
    end
  end

  def calculate_average(ratings)
    return 0 if ratings.count == 0
    (ratings.inject{ |sum, el| sum + el }.to_f / ratings.size).round(1)
  end

end
