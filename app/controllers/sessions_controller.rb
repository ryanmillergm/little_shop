class SessionsController < ApplicationController
  def new
  end

  def destroy
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are now logged in!"
      redirect_user(user)
    else
      flash.now[:danger] = "Sorry, that email and password don't match."
      render :new
    end
  end

  private

  def redirect_user(user)
    if user.default?
      redirect_to profile_path
    elsif user.merchant?
      redirect_to dashboard_path
    elsif user.admin?
      redirect_to root_path
    end
  end
end
