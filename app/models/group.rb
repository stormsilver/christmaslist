class Group < ActiveRecord::Base
  has_many :group_memberships, inverse_of: :group
  has_many :people, through: :group_memberships
  belongs_to :creator, class_name: 'Person'

  validates_presence_of :name, :creator

  def editable_by? person
    creator == person
  end
end
