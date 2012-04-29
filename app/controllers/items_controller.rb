class ItemsController < ApplicationController
  before_filter :save_last_server, only: [:index]

  def index
    if params[:query]
      @items = Item.paginated_search(params[:query], params)
    else
      @products = Product.includes(:shop).where('shops.server_id' => current_server.id).order('shops.seen_time DESC').limit(10).all
    end
  end

  def show
    @item = Item.find(params[:id])
    @products = @item.products_from_server(current_server.id)
  end

  private

  def save_last_server
    if cookies[:server_id] != current_server.id
      cookies[:server_id] = { value: current_server.id, expires: 10.years.from_now } 
    end
  end
end
