class Dashboard::ItemsController < Dashboard::BaseController
  def index
    @items = current_user.items
  end
end
