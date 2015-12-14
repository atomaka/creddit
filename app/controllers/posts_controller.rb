# controllers/posts_controller.rb
class PostsController < ApplicationController
  before_filter :set_post, except: [:index, :new, :create]
  before_filter :set_subcreddit
  after_action :verify_authorized

  def index
    @posts = Post.includes(:subcreddit, :user).all

    authorize Post
  end

  def show
    @comments = @post.comments.includes(:user).arrange(order: :created_at)

    authorize @post
  end

  def new
    @post = Post.new

    authorize @post
  end

  def create
    @post = @subcreddit.posts.build(post_params)
    @post.user = current_user

    authorize @post

    if @post.save
      redirect_to subcreddit_post_path(@subcreddit, @post),
        notice: 'Post created'
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to subcreddit_post_path(@subcreddit, @post),
        notice: 'Post was updated'
    else
      render :edit
    end
  end

  def destroy
    authorize @post

    @post.destroy

    redirect_to subcreddits_path(@subcreddit), notice: 'Post was deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :content, :subcreddit_id)
  end

  def set_subcreddit
    @subcreddit = Subcreddit.find_by_slug(params['subcreddit_id'])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
