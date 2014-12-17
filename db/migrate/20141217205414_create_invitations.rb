class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.timestamps

      t.belongs_to :group
      t.belongs_to :sender
      t.belongs_to :recipient
    end
  end
end
