class ItemsController < ApplicationController
  layout 'modal', except: :index

  before_action :set_person_and_list
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_create_url, only: [:new, :create]
  before_action :set_edit_url, only: [:edit, :update]


  def index
    @items = @list.items
    if @list.person == current_person
      render action: 'index_owner'
    end
  end

  def show
  end

  def new
    set_page_title 'Add Item'
    @item = @list.items.build
  end

  def edit
  end

  def create
    @item = @list.items.build(item_params)
    if @item.save
      redirect_via_turbolinks_to @submit_url
    else
      render action: 'new'
    end
  end

  def update
    @item.update(item_params)
  end

  def destroy
    @item.destroy
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

  def set_create_url
    @submit_url = if @group
      group_list_items_path(@group, @list)
    else
      list_items_path(@list)
    end
  end

  def set_edit_url
    @submit_url = if @group
      group_list_item_path(@group, @list)
    else
      list_item_path(@list)
    end
  end

  def item_params
    params.require(:item).permit(:name).merge(creator: current_person)
  end
end
