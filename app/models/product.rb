class Product < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  belongs_to :shop

  attr_accessible :item_id, :count, :price, :enchant

  def item
    Item.find(item_id)
  end

  def to_s
    str = item.name
    str += " [#{item.sa}]" if item.sa.present?
    str += " +#{enchant}" if enchant > 0
    str
  end
end
