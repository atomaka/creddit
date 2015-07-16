class AddCommentsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0

    Post.reset_column_information
    Post.all.each do |p|
      p.update_attribute :comments_count, p.comments.length
    end
  end
end
