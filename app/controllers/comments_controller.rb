# controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_filter :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :set_post
  before_filter :set_subcreddit
  after_action :verify_authorized

  def show
    @comments = @comment
                  .subtree
                  .includes(:post, :user)
                  .arrange(order: :created_at)

    authorize @comment
  end

  def new
    @comment = Comment.new(params[:parent_id])

    authorize @comment
  end

  def create
    @comment = @post.comments.build comment_params
    @comment.user = current_user

    authorize @comment

    if @comment.save
      flash[:notice] = 'Comment saved'
    else
      flash[:alert] = 'Comment could not be saved'
    end

    redirect_to subcreddit_post_path(@subcreddit, @post)
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment

    if @comment.update comment_params
      redirect_to subcreddit_post_path(@subcreddit, @post),
        notice: 'Comment updated'
    else
      render :edit
    end
  end

  def destroy
    authorize @comment

    @comment.destroy
    redirect_to subcreddit_post_path(@subcreddit, @post),
      notice: 'Comment deleted'
  end

  private

  def set_subcreddit
    @subcreddit = Subcreddit.friendly.find(params[:subcreddit_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:parent_id, :content)
  end
end
