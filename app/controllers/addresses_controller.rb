class AddressesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @address = Address.new
  end

  def create
    @user = User.find(params[:user_id])
    @address = @user.addresses.new(address_params)
    @address.save
    @user.save
    redirect_to profile_path(@user)

  end

  private

  def address_params
    params.require(:address).permit(:nickname, :address, :city, :state, :zip)
  end
end
