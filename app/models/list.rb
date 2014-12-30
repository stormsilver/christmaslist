class List < ActiveRecord::Base
  has_many :items, inverse_of: :list
  belongs_to :person, inverse_of: :lists
  has_many :groups, through: :person

  validates_presence_of :person

  scope :current, -> {where(created_at: Time.current.beginning_of_year..Time.current.end_of_year)}
end
