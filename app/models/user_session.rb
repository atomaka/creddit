class UserSession < ActiveRecord::Base
  belongs_to :user

  before_validation :set_unique_key

  attr_accessor :username, :password

  def self.authenticate(key)
    self.find_by_key(key)
  end

  def self.new_by_user(user, env)
    user_session = UserSession.new(
      user: user,
      user_agent: env['HTTP_USER_AGENT'],
      ip: env['REMOTE_ADDR']
    )
    user_session.save
    user_session
  end

  private

  def set_unique_key
    self.key = SecureRandom.urlsafe_base64(32)
  end
end
