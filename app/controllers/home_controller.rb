class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    set_page_title "Welcome to Christmas List #{Date.today.year}!"
  end
end
