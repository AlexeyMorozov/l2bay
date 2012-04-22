class Product < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  belongs_to :shop

  attr_accessible :item_id, :count, :price, :enchant

  def item
    Item.find(item_id)
  end
end
