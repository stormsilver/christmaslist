class InvitationsController < ApplicationController
  before_action :set_group
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @invitation = @group.invitations.build
  end

  def edit
  end

  def create
    @invitation = @group.invitations.build invitation_params
    if @invitation.save
      if @invitation.recipient
        InvitationMailer.existing_user_invitation(@invitation).deliver
        # Add the user to the group
        @invitation.group.people << @invitation.recipient
      else
        InvitationMailer.new_user_invitation(@invitation, new_user_registration_url(:invitation_token => @invitation.token)).deliver
      end
      redirect_to edit_group_path(@group), notice: 'Your invitation was created.'
    else
      render action: 'new'
    end
  end

  # def update
  #   if @invitation.update(group_params)
  #     redirect_to group_path(@group), notice: 'Your invitation was created.'
  #   else
  #     render action: 'edit'
  #   end
  # end

  # def destroy
  #   @group.destroy
  # end

  private
  def set_group
    @group = current_person.groups.find(params[:group_id])
  end

  def set_invitation
    @invitation = @group.invitations.find params[:id]
  end

  def invitation_params
    params.require(:invitation).permit(:email).merge(sender: current_person)
  end
end
