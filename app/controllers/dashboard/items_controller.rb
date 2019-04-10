class Dashboard::ItemsController < Dashboard::BaseController
  def index
    @items = current_user.items
  end

  def enable
    @item = Item.find(params[:id])
    if @item.user == current_user
      toggle_active(@item, true)
      redirect_to dashboard_items_path
    else
      render file: 'public/404', status: 404
    end
  end

  def disable
    @item = Item.find(params[:id])
    if @item.user == current_user
      toggle_active(@item, false)
      redirect_to dashboard_items_path
    else
      render file: 'public/404', status: 404
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item && @item.user == current_user
      if @item && @item.ordered?
        flash[:error] = "Attempt to delete #{@item.name} was thwarted!"
      else
        @item.destroy
      end
      redirect_to dashboard_items_path
    else
      render file: 'public/404', status: 404
    end
  end

  private

  def toggle_active(item, state)
    item.active = state
    item.save
  end
end
