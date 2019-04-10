class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 'default')
  end

  def show
    @user = User.find(params[:id])
  end
end
