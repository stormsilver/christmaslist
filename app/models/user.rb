class User < ActiveRecord::Base
  has_one :person, inverse_of: :user
  accepts_nested_attributes_for :person
  has_many :guardianships, inverse_of: :user
  has_many :wards, through: :guardianship

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :person

  after_initialize :make_person

  private
  def make_person
    self.build_person unless person
  end
end
