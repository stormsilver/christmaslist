class Invitation < ActiveRecord::Base
  belongs_to :group, inverse_of: :invitations
  belongs_to :sender, :class_name => 'Person', inverse_of: :sent_invitations
  belongs_to :recipient, :class_name => 'Person', inverse_of: :invitations

  before_create :generate_token
  before_save :check_user_existence, unless: :recipient

  scope :unaccepted, -> {where(recipient_id: nil)}

  private
  def generate_token
    self.token = Devise.friendly_token
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient = recipient
    end
  end
end
