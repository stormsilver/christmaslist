module ApplicationHelper
  def active_class_if a, b
    html_class = nil
    if a == b
      html_class = 'active'
    end
    html_class
  end
end
