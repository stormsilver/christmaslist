class Person < ActiveRecord::Base
  enum gender: [ :male, :female ]

  belongs_to :user, inverse_of: :person
  has_one :addresses, inverse_of: :person
  has_many :group_memberships, inverse_of: :person
  has_many :groups, through: :group_memberships
  has_many :guardianships, inverse_of: :person
  has_many :guardians, through: :guardianship
  has_many :items, class_name: 'Item', inverse_of: :creator
  has_many :lists, inverse_of: :person do
    def current
      where(created_at: Time.current.beginning_of_year..Time.current.end_of_year).first
    end
  end
  has_many :purchases, class_name: 'Item', inverse_of: :purchaser

  validates_presence_of :first_name, :last_name, :gender

  after_create :make_initial_list

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  private
  def make_initial_list
    lists.create
  end
end
