class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string   "address1"
      t.string   "address2"
      t.string   "city"
      t.string   "state",            limit: 3
      t.string   "postal"
      t.string :country, default: "US"
      t.timestamps

      t.belongs_to :person
    end
  end
end
