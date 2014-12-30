module ApplicationHelper
  def active_class_if a, b
    html_class = nil
    method = :==
    if a.is_a?(Regexp)
      method = :=~
    end
    if a.public_send(method, b)
      html_class = 'active'
    end
    html_class
  end

  def modal_button text, path, tooltip = nil
    options = {class: 'btn btn-default modal-trigger'}
    if tooltip
      options[:data] = {toggle: "tooltip"}
      options[:title] = tooltip
    end
    link_to text, path, options
  end

  def modal_close_button
    content_tag :button, 'Close', type: 'button', class: "btn btn-default", data: {dismiss: 'modal'}
  end
end
