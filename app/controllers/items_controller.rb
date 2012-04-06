class ItemsController < ApplicationController
  def index
    if params[:query]
      @items = Item.paginated_search(params[:query], params)
    else
      @products = Product.includes(:shop).order('shops.seen_time DESC').limit(10).all
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end
