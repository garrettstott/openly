module Iconable

  def approved_icon
    boolean_to_icon(approved)
  end

  def denied_icon
    boolean_to_icon(denied)
  end

  def boolean_to_icon(style)
    icon = ''
    if style == true
      icon = '<i class="fa fa-check"></i>'
    else
      icon = '<i class="fa fa-times"></i>'
    end
    icon.html_safe
  end
end
