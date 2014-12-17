class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.timestamps

      t.belongs_to :person
    end
  end
end
