class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action do
    @todays_year = Date.current.year
  end
  before_action :change_current_year

  def current_person
    current_user.person
  end
  helper_method :current_person

  def current_year
    current_user.last_year_viewed || @todays_year
  end
  helper_method :current_year

  def after_sign_in_path_for(user)
    redirect_location = stored_location_for(user)
    redirect_location ||= path_to_current_list
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

  def available_years_for_navigation
    @_available_years_for_navigation ||= (2015..@todays_year).to_a.reverse
  end
  helper_method :available_years_for_navigation

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(person_attributes: [:first_name, :last_name, :gender])
    end
  end

  def path_to_current_list
    current_list = current_person.list_for_year(current_year) || current_person.lists.create
    list_items_path(current_list)
  end

  def change_current_year
    new_year = params[:change_year_to]&.to_i
    return if new_year.blank? || !available_years_for_navigation.include?(new_year)
    current_user.update(last_year_viewed: new_year)
  end
end
