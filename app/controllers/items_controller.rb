class ItemsController < ApplicationController
  before_action :set_person_and_list
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @items = Item.all
    respond_with(@items)
  end

  def show
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(@item)
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    respond_with(@item)
  end

  private
  def set_person_and_list
    if params[:group_id]
      @group = current_person.groups.find(params[:group_id])
      @list = List.joins(:groups).where(id: params[:list_id], groups: {id: @group.id}).first
      @person = @list.person
    else
      @list = current_person.lists.find(params[:id])
      @person = current_person
    end
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params[:item]
  end
end
