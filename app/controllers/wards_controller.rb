class WardsController < ApplicationController
  before_action :set_ward, except: [:index, :new, :create]

  def index
    @wards = current_user.wards
  end

  def show
  end

  def new
    @ward = current_user.wards.build last_name: current_person.last_name
  end

  def edit
  end

  def create
    @ward = current_user.wards.build ward_params
    if @ward.save
      redirect_to wards_path, notice: 'Your ward was created.'
    else
      render action: 'new'
    end
  end

  def update
    if @ward.update(ward_params)
      redirect_to wards_path, notice: 'Your ward was updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @ward.destroy
  end

  private
  def set_ward
    @ward = current_user.wards.find params[:id]
  end

  def ward_params
    params.require(:person).permit(:first_name, :last_name, :gender)
  end
end
