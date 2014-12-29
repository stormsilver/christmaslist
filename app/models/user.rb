class User < ActiveRecord::Base
  has_one :person, inverse_of: :user
  accepts_nested_attributes_for :person
  has_many :guardianships, inverse_of: :user
  has_many :wards, through: :guardianship

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :person

  after_initialize :make_person

  def self.new_with_session params, session
    user = new params
    user.email = session[:invitation_email] if session[:invitation_email]
    user
  end

  private
  def make_person
    self.build_person unless person
  end
end
