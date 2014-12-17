class Item < ActiveRecord::Base
  belongs_to :list, inverse_of: :items
  belongs_to :creator, class_name: 'Person', inverse_of: :items
  belongs_to :purchaser, class_name: 'Person', inverse_of: :purchases
end
