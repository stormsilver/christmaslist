class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_person
    current_user.person
  end

  def after_sign_in_path_for(user)
    redirect_location = stored_location_for(user)
    unless redirect_location
      # list path for current list
      # no list? create list path
    end
    redirect_location
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << {person_attributes: [:first_name, :last_name, :gender]}
  end
end
