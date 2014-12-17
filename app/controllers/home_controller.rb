class HomeController < ApplicationController
  skip_filter :authenticate_user!

  def index
  end
end
