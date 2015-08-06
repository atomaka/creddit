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
    length: { minimum: 3, maximum: 21 },
    sluguuidless: true

  validates :closed,
    format: /\A[01]?\z/

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
end
