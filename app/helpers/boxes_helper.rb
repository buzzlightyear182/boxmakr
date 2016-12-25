module BoxesHelper

  def badge_label(box_type)
    case box_type
    when 'Trial'
      content_tag(:span, box_type, :class => "label label-warning")
    when 'Regular'
      content_tag(:span, box_type, :class => "label label-success")
    when 'Premium'
      content_tag(:span, box_type, :class => "label label-info")
    end
  end

  def check?(month_date)
    if Date.today.beginning_of_month == month_date
      icon('check', :class => 'text-success')
    end
  end

end