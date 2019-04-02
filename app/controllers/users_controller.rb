class UsersController < ApplicationController
  before_action :require_reguser, only: :show

  def new
  end

  def show
  end
end