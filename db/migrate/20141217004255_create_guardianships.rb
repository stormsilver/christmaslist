class CreateGuardianships < ActiveRecord::Migration
  def change
    create_table :guardianships do |t|
      t.belongs_to :user
      t.belongs_to :person
      t.timestamps
    end
  end
end
