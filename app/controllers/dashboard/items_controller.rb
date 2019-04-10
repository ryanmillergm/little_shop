class Dashboard::ItemsController < Dashboard::BaseController
  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    @item.active = true
    if @item.save
      flash[:success] = "Your Item has been saved!"
      redirect_to dashboard_items_path
    else
      flash[:danger] = @item.errors.full_messages
      render :new
    end
  end

  private

  def item_params
    item_parameters = params.require(:item).permit(:name, :price, :description, :image, :inventory)
    if item_parameters[:image].empty?
      item_parameters[:image] = "https://picsum.photos/200/300"
    end
    item_parameters
  end
end
