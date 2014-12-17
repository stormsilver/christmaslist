class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_person.groups
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = current_person.groups.build group_params
    @group.group_memberships.build person: current_person
    if @group.save
      redirect_to groups_path, notice: 'Your group was created.'
    else
      render action: 'new'
    end
  end

  def update
    @group.update(group_params)
  end

  def destroy
    @group.destroy
  end

  private
  def set_group
    @group = current_person.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name).merge(creator: current_person)
  end
end
