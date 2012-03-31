class ItemsController < ApplicationController
  def index
    if params[:query].blank?
      @items = Item.find((7575..7594).to_a)
    else
      @items = Item.search(params[:query])
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end
