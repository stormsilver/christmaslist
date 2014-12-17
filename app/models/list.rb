class List < ActiveRecord::Base
  has_many :items, inverse_of: :list
  belongs_to :person, inverse_of: :lists

  validates_presence_of :person


end
