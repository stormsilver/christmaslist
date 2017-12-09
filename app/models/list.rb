class List < ActiveRecord::Base
  has_many :items, inverse_of: :list
  belongs_to :person, inverse_of: :lists
  has_many :groups, through: :person

  validates_presence_of :person

  scope :for_year, ->(year) { where("date_part('year', #{self.quoted_table_name}.created_at) = ?".freeze, year).order(created_at: :desc) }

  def year
    created_at.year
  end
end
