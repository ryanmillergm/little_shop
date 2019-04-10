class Admin::UsersController < Admin::BaseController
  def index
    @users = User.default_users
  end

  def show
    @user = User.find(params[:id])
    if @user.role == "merchant"
      redirect_to admin_merchant_path(@user)
    end
  end
end
