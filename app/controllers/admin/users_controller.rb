class Admin::UsersController < Admin::BaseController
  def index
    @users = User.default_users
  end

  def show
    @user = User.find(params[:id])
  end
end
