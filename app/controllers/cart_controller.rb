class CartController < ApplicationController
  before_action :visitor_or_user

  def show
  end

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:success] = "#{item.name} has been added to your cart!"
    redirect_to items_path
  end
end
