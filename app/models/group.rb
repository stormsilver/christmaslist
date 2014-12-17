class Group < ActiveRecord::Base
  has_many :group_memberships, inverse_of: :group
  has_many :people, through: :group_memberships
  belongs_to :creator, class_name: 'Person'
end
