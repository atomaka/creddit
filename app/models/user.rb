class User < ActiveRecord::Base
  has_secure_password

  before_save :downcase_email

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }

  private

  def downcase_email
    self.email = self.email.downcase
  end
end
