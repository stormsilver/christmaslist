class Item < ActiveRecord::Base
  belongs_to :list, inverse_of: :items
  belongs_to :creator, class_name: 'Person', inverse_of: :created_items
  belongs_to :purchaser, class_name: 'Person', inverse_of: :purchases
  delegate :person, :to => :list, :allow_nil => true

  validates_presence_of :name, :list, :creator
  validates_format_of :url, with: URI.regexp, allow_blank: true

  before_validation :correctify_url
  before_validation :remove_empty_price

  scope :purchased_by, ->(p){ where(purchaser: p) }
  scope :purchased, ->{ where.not(purchaser: nil) }
  scope :unpurchased, ->{ where(purchaser: nil) }
  scope :without_deleted, -> { where(deleted: false) }

  def pretty_url
    matches = /(^https?:\/\/)?([^\/]+\.)?([^\/]+\.[^\/]+)(\/.*)?/i.match(url)
    matches[3]
  end

  def purchased_by? person
    purchaser == person
  end

  def destroy_or_hide
    if purchaser
      update deleted: true
    else
      destroy
    end
  end

  private
  def correctify_url
    return if url.blank?

    rval = url
    if !rval.match(/.*[\.]+.*/i)
      rval = "http://www.#{rval}.com"
    end

    if !rval.match(/(http|https):\/\/.*/i)
      rval = 'http://' + rval
    end

    self.url = rval
  end

  def remove_empty_price
    self.price = nil if price == 0
  end
end
