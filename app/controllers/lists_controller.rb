class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all
  end

  def show
    if @list.person == current_person
      render action: 'owner'
    end
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.save
  end

  def update
    @list.update(list_params)
  end

  def destroy
    @list.destroy
  end

  private
  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params[:list]
  end
end
