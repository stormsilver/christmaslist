class Person < ActiveRecord::Base
  class Gender
    GENDERS = %i{male female}
    GENDERS.each do |k|
      const_set k.upcase, k.to_s
    end
  end

  belongs_to :user, inverse_of: :person
  has_one :addresses, inverse_of: :person
  has_many :group_memberships, inverse_of: :person
  has_many :groups, through: :group_memberships
  has_many :guardianships, inverse_of: :person
  has_many :guardians, through: :guardianship
  has_many :items, class_name: 'Item', inverse_of: :creator
  has_many :lists, inverse_of: :person
  has_many :purchases, class_name: 'Item', inverse_of: :purchaser

  validates_presence_of :first_name, :last_name, :gender

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end
end
