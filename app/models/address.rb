class Address < ActiveRecord::Base
  belongs_to :person, inverse_of: :address

  validates_presence_of :address1, :city, :state, :postal, :country
end
