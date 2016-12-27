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

  def show_checkbox(item, box)
    if box.has_item?(item)
      render 'checked', :item => item, box: box
    else
      render 'unchecked', :item => item, box: box
    end
  end

end