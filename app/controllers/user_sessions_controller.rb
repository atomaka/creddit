class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)

    user = User.find_by_username(params[:user_session][:username])

    if authenticate_user?(user)
      create_user_session(user)

      redirect_to root_path, notice: 'You have been signed in!'
    else
      redirect_to signin_path, alert: 'Username or password was incorrect!'
    end
  end

  def destroy
    cookies.permanent[:user_session] = nil
    current_session.destroy if current_session

    redirect_to root_path, notice: 'You have been signed out!'
  end

  private

  def user_session_params
    params.require(:user_session).permit(:username, :password)
  end

  def authenticate_user?(user)
    user && user.authenticate(params[:user_session][:password])
  end

  def create_user_session(user)
    user_session = UserSession.new_by_user(user, request.env)

    cookies.permanent[:user_session] = user_session.key
  end
end
