class InvitationMailer < ApplicationMailer
  def existing_user_invitation invitation
    @invitation = invitation
    mail(to: @invitation.email, subject: "You've been added to the #{@invitation.group.name} Christmas list")
  end

  def new_user_invitation invitation, signup_path
    @invitation = invitation
    @signup_path = signup_path
    mail(to: @invitation.email, subject: "Join my #{@invitation.group.name} Christmas list")
  end
end
