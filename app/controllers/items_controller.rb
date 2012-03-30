class ItemsController < ApplicationController
  def index
    @items = Item.all.first(20)
  end

  def show
    @item = Item.find(params[:id])
  end
end
