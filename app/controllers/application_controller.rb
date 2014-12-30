class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_person
    current_user.person
  end
  helper_method :current_person

  def after_sign_in_path_for(user)
    redirect_location = stored_location_for(user)
    unless redirect_location
      redirect_location = if current_person.lists.current.first
        list_items_path(current_person.lists.current.first)
      else
        new_list_path
      end
    end
    redirect_location
  end

  def set_page_title title
    @page_title = title
  end

  def page_title
    @page_title ||= controller_name.titleize
    @page_title
  end
  helper_method :page_title

  def set_page_subtitle title
    @page_subtitle = title
  end
  def page_subtitle
    @page_subtitle
  end
  helper_method :page_subtitle

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << {person_attributes: [:first_name, :last_name, :gender]}
  end
end
