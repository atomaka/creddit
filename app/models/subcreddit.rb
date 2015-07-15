RESERVED_SLUGS = %w(new edit)

class Subcreddit < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :posts

  attr_accessor :closed

  before_save :set_slug
  before_save :set_closed_at

  validates :name,
    presence: true,
    format: /\A(?! )[a-z0-9 ]*(?<! )\z/i,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 21 }

  validate :slug_is_not_a_route

  validates :closed,
    format: /\A[01]?\z/

  def to_param
    self.slug
  end

  def closed?
    self.closed_at != nil
  end

  private

  def set_slug
    self.slug = sluggify_name
  end

  def sluggify_name
    self.name.downcase.tr(' ', '_')
  end

  def set_closed_at
    if closed == '1' && closed_at == nil
      self.closed_at = Time.now
    elsif closed == '0' && closed_at != nil
      self.closed_at = nil
    end
  end

  def slug_is_not_a_route
    if RESERVED_SLUGS.include?(sluggify_name)
      errors.add(:name, 'cannot be a reserved keyword')
    end
  end
end
