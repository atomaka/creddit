class Subcreddit < ActiveRecord::Base
  extend FriendlyId

  belongs_to :owner, class_name: 'User'
  has_many :posts

  friendly_id :name, use: :slugged

  attr_accessor :closed

  delegate :username, to: :owner, prefix: true

  before_save :set_closed_at

  validates :name,
    presence: true,
    format: /\A(?! )[a-z0-9 ]*(?<! )\z/i,
    uniqueness: true, #{ case_sensitive: false },
    length: { minimum: 3, maximum: 21 }

  validates :closed,
    format: /\A[01]?\z/

  validate :slug_does_not_have_uuid

  def closed?
    self.closed_at != nil
  end

  private

  def set_closed_at
    if closed == '1' && closed_at == nil
      self.closed_at = Time.now
    elsif closed == '0' && closed_at != nil
      self.closed_at = nil
    end
  end

  def slug_does_not_have_uuid
    if self.slug.match /([a-z0-9]+\-){4}[a-z0-9]+\z/
      errors.add(:name, 'must be unique')
    end
  end
end
