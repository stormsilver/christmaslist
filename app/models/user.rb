class User < ActiveRecord::Base
  has_one :person, inverse_of: :user
  has_many :guardianships, inverse_of: :user
  has_many :wards, through: :guardianship

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
