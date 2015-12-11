# models/post.rb
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subcreddit

  has_many :comments

  delegate :username, to: :user, prefix: true
  delegate :slug, to: :subcreddit, prefix: true

  validates :title,
    presence: true,
    length: { maximum: 300 }

  validates :content,
    length: { maximum: 15000 }

  def to_param
    # This "just works" because of the way Rails IDs work.  .to_i must be run on
    # any incoming ID.  "1-title-parameterized" will automatically be converted
    # to 1 and "2-title-paramerterized-with-number-2" will automatically be
    # converted to 2.  This gives us desired functionality without adding code
    # to properly handle retrieving based on slug.  Hopefully, this does not
    # cause issues later on.
    "#{self.id}-#{self.title.parameterize}"
  end

  def comments?
    self.comments_count != 0
  end
end
