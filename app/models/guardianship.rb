class Guardianship < ActiveRecord::Base
  belongs_to :user, inverse_of: :guardianships
  belongs_to :person, inverse_of: :guardianships
end
