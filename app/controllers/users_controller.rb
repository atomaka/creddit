# controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @comments = @user.comments.includes(:post)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to signin_path, notice: 'Your user account has been created'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
