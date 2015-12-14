# models/user.rb
class User < ActiveRecord::Base
  extend FriendlyId

  has_secure_password

  has_many :comments
  has_many :posts

  friendly_id :username, use: :slugged

  before_save :downcase_email

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, sluguuidless: true
  validates :password, length: { minimum: 8 }

  def registered?
    true
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
