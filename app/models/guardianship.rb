class Guardianship < ActiveRecord::Base
  belongs_to :user, inverse_of: :guardianship
  belongs_to :person, inverse_of: :guardianship
end
