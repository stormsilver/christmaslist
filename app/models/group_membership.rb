class GroupMembership < ActiveRecord::Base
  belongs_to :person, inverse_of: :group_membership
  belongs_to :group, inverse_of: :group_membership
end
