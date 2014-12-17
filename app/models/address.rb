class Address < ActiveRecord::Base
  belongs_to :person, inverse_of: :address
end
