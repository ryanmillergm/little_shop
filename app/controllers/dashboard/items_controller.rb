class Dashboard::ItemsController < Dashboard::BaseController
  def index
    @items = current_user.active_items
  end
end