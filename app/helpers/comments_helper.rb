# helpers/comments_helper.rb
module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment, post: comment.post, subcreddit: comment.post_subcreddit) +
        content_tag(:div,
                    nested_comments(sub_comments),
                    class: 'nested_comments')
    end.join.html_safe
  end
end
