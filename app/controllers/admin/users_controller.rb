class Admin::UsersController < Admin::BaseController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def upgrade
    user = User.find(params[:id])
    user.update(role: :merchant)
    flash[:success] = "#{user.name} is now a merchant."
    redirect_to admin_merchant_path(user)
  end
end
