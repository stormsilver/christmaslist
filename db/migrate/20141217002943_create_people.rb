class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string   :first_name
      t.string   :last_name
      t.boolean  :gender
      t.timestamps

      t.belongs_to :user
    end
  end
end
