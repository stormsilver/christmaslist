class AddLastYearToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_year_viewed, :integer
  end
end
