class Person < ActiveRecord::Base
  enum gender: [ :male, :female ]

  belongs_to :user, inverse_of: :person
  # has_one :addresses, inverse_of: :person, dependent: :destroy
  has_many :group_memberships, inverse_of: :person, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_one :guardianship, inverse_of: :person, dependent: :destroy
  has_one :guardian, through: :guardianship, source: :user
  has_many :created_items, class_name: 'Item', foreign_key: :creator_id, inverse_of: :creator, dependent: :destroy
  has_many :purchases, class_name: 'Item', foreign_key: :purchaser_id, inverse_of: :purchaser, dependent: :destroy
  has_many :lists, inverse_of: :person, dependent: :destroy
  has_many :invitations, :foreign_key => 'recipient_id', inverse_of: :recipient
  has_many :sent_invitations, :class_name => "Invitation", :foreign_key => 'sender_id', inverse_of: :sender

  validates_presence_of :first_name, :last_name, :gender

  after_create :make_initial_list

  scope :by_name, -> { order(:first_name) }
  scope :without, ->(people) { where.not(id: Array(people).flatten.compact) }

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def list_for_year(year)
    @_lists ||= {}
    @_lists[year] ||= lists.for_year(year).first
  end

  def current_purchases_for person_or_group, year
    case person_or_group
    when Person
      list = person_or_group.list_for_year(year)
      if list
        list.items.purchased_by(self)
      else
        []
      end
    when Group
      list_ids = List.for_year(year).joins(:person).where(people: {id: person_or_group.people.pluck(:id)}).pluck(:id)
      Item.purchased_by(self).joins(:list).where(lists: {id: list_ids })
    end
  end

  # Returns the user's gender as a string. +form+ describes what type of string will be returned. If you need it capitalized, pass +capitalize+ as true.
  def gender_to_s(form = :objective, capitalize = false)
    rval = ''
    case form
    when :possessive
      if female?
        rval = 'hers'
      else
        rval = 'his'
      end
    when :possessive_adjective
      if female?
        rval = 'her'
      else
        rval = 'his'
      end
    when :objective
      if female?
        rval = 'her'
      else
        rval = 'him'
      end
    when :subjective
      if female?
        rval = 'she'
      else
        rval = 'he'
      end
    when :reflexive
      if female?
        rval = 'herself'
      else
        rval = 'himself'
      end
    end

    if capitalize
      return rval.capitalize
    else
      return rval
    end
  end

  private
  def make_initial_list
    lists.create
  end
end
