class AddressesController < ApplicationController

  def new
    @user = User.find(params[:id])
  end
end
