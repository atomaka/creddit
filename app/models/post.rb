class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subcreddit

  validates :title,
    presence: true,
    length: { maximum: 300 }

  validates :content,
    length: { maximum: 15000 }

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
end
