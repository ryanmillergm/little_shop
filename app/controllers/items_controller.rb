class ItemsController < ApplicationController
  def index
    @items = Item.where(active: true).order(name: :asc)
  end

  def show
  end
end