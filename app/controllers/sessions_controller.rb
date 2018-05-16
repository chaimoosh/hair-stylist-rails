class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def new
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user == nil
      redirect_to root_path
    else
      redirect_to user_path(@user)
    end
  end
end
