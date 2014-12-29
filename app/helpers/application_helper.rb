module ApplicationHelper
  def active_class_if a, b
    html_class = nil
    if a == b
      html_class = 'active'
    end
    html_class
  end

  def modal_button text, path
    link_to text, path, class: 'btn modal-trigger'
  end

  def modal_close_button
    content_tag :button, 'Close', type: 'button', class: "btn btn-default", data: {dismiss: 'modal'}
  end
end
