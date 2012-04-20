class ItemsController < ApplicationController
  def index
    @server = Server.find_by_name!(params[:server].capitalize)
    if params[:query]
      @items = Item.paginated_search(params[:query], params)
    else
      @products = Product.includes(:shop).where('shops.server_id' => @server.id).order('shops.seen_time DESC').limit(10).all
    end
  end

  def show
    @server = Server.find_by_name!(params[:server].capitalize)
    @item = Item.find(params[:id])
    @products = @item.products_from_server(@server.id)
  end
end
