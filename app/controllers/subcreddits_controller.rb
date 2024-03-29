# controllers/subcreddits_controller.rb
class SubcredditsController < ApplicationController
  before_filter :set_subcreddit, only: [:show, :edit, :update]
  after_action :verify_authorized

  def index
    @subcreddits = Subcreddit.all

    authorize Subcreddit
  end

  def show
    @posts = @subcreddit.posts.includes(:user)

    authorize @subcreddit
  end

  def new
    @subcreddit = Subcreddit.new

    authorize @subcreddit
  end

  def create
    @subcreddit = Subcreddit.new(create_subcreddit_params)
    @subcreddit.owner = current_user

    authorize @subcreddit

    if @subcreddit.save
      redirect_to @subcreddit, notice: 'Subcreddit was created!'
    else
      render :new
    end
  end

  def edit
    authorize @subcreddit
  end

  def update
    authorize @subcreddit

    if @subcreddit.update(update_subcreddit_params)
      redirect_to @subcreddit, notice: 'Subcreddit was updated!'
    else
      render :edit
    end
  end

  private

  def create_subcreddit_params
    params.require(:subcreddit).permit(:name)
  end

  def update_subcreddit_params
    params.require(:subcreddit).permit(:closed)
  end

  def set_subcreddit
    @subcreddit = Subcreddit.friendly.find(params[:id])
  end
end
