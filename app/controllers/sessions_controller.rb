class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user.nil?
      flash.now[:errors] = ["invalid username / password"]
      render :new
    else
      if user.is_password?(params[:user][:password])
        login_user!(user)
      else
        flash.now[:errors] = ["invalid username / password"]
        render :new
      end
    end
  end

  def destroy
  end
end
