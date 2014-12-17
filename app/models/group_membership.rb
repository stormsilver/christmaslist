class GroupMembership < ActiveRecord::Base
  belongs_to :person, inverse_of: :group_memberships
  belongs_to :group, inverse_of: :group_memberships
end
