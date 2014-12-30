class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :name
      t.text    :description
      t.string  :url
      t.float   :price, default: 0.0
      t.boolean :deleted, default: false
      t.timestamps

      t.belongs_to :list
      t.belongs_to :purchaser
      t.belongs_to :creator
    end
  end
end
