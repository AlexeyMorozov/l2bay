class ItemsController < ApplicationController
  def index
    @items = Item.paginated_search(params[:query], params) if params[:query]
  end

  def show
    @item = Item.find(params[:id])
  end
end
