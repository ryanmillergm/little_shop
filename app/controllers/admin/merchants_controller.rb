class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = User.find(params[:id])
    render :'/dashboard/dashboard/index'
  end
end