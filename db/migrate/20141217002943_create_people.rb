class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string   :first_name
      t.string   :last_name
      t.integer  :gender, limit: 1
      t.timestamps

      t.belongs_to :user
    end
  end
end
