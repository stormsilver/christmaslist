module ApplicationHelper
  def active_class_if a, b = nil, html_class: 'active'
    active = false

    if a.respond_to?(:call)
      active = a.call
    else
      method = :==
      if a.is_a?(Regexp)
        method = :=~
      end
      active = a.public_send(method, b)
    end

    active ? html_class : ''
  end

  def modal_button text, path, tooltip: nil, html_class: 'btn btn-default'
    options = {class: html_class + ' modal-trigger'}
    if tooltip
      options[:data] = {toggle: "tooltip"}
      options[:title] = tooltip
    end
    link_to text, path, options
  end

  def modal_close_button
    content_tag :button, 'Close', type: 'button', class: "btn btn-default", data: {dismiss: 'modal'}
  end

  def days_until_christmas
    now = Date.today
    christmas = Date.new now.year, 12, 25
    # next year
    christmas = Date.new now.year+1, 12, 25 if now > christmas

    (christmas - now).to_i
  end
end
