module NiceDateable

  def nice_date_full(date)
    date.strftime('%m/%d/%Y %l:%M:%S %p') rescue ''
  end

  def nice_date(date)
    date.strftime('%m/%d/%Y') rescue ''
  end
end
