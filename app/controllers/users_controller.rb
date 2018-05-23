class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end 
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
