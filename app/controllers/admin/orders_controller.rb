class Admin::OrdersController < Admin::BaseController
  def show
    @merchant = User.find(params[:merchant_id])
    @order = Order.find(params[:id])
    @user = @order.user
    @order_items = @order.order_items_for_merchant(@merchant.id)

    render :'/dashboard/orders/show'
  end
end