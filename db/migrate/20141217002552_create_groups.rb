class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps

      t.belongs_to :creator
    end
  end
end
