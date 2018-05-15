class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
    @user = User.find_by(id: params[:id])
    if session[:user_id] != @user.id && @user.admin == false
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :password, :admin)
  end
end
