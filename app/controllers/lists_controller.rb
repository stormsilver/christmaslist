class ListsController < ApplicationController
  # before_action :set_person_and_list
  #
  # def index
  #   @lists = @person.lists
  # end
  #
  # def show
  #   if @list.person == current_person
  #     render action: 'owner'
  #   end
  # end
  #
  # private
  #
  # def set_person_and_list
  #   if params[:group_id]
  #     @group = current_person.groups.find(params[:group_id])
  #     @list = List.joins(:groups).where(id: params[:id], groups: {id: @group.id}).first
  #     @person = @list.person
  #   else
  #     @list = current_person.list_for_year(current_year)
  #     @person = current_person
  #   end
  # end
end
