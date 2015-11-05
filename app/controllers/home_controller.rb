class HomeController < ApplicationController
  skip_filter :authenticate_user!

  def index
    set_page_title "Welcome to Christmas List #{Date.today.year}!"
  end
end
