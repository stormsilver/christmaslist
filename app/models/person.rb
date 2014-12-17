class Person < ActiveRecord::Base
  belongs_to :user, inverse_of: :person
  has_one :addresses, inverse_of: :person
  has_many :group_memberships, inverse_of: :person
  has_many :groups, through: :group_memberships
  has_many :guardianships, inverse_of: :person
  has_many :guardians, through: :guardianship
  has_many :items, class_name: 'Item', inverse_of: :creator
  has_many :lists, inverse_of: :person
  has_many :purchases, class_name: 'Item', inverse_of: :purchaser
end
