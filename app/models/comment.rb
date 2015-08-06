class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  belongs_to :post, counter_cache: true

  delegate :username, to: :user, prefix: true

  validates :content, presence: true

  def content
    destroyed? ? '[deleted]' : read_attribute(:content)
  end

  def destroy
    update_attribute(:deleted_at, Time.now)
  end

  def destroyed?
    self.deleted_at != nil
  end
end
