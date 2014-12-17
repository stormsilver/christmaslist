class List < ActiveRecord::Base
  has_many :items, inverse_of: :list
  belongs_to :person, inverse_of: :list
end