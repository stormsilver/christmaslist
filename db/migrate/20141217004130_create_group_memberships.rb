class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.belongs_to :group
      t.belongs_to :person
      t.timestamps
    end
  end
end
