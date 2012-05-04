class Product < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  belongs_to :shop

  scope :being_sold, joins(:shop).where(shops: {sell: true})
  scope :being_bought, joins(:shop).where(shops: {sell: false})
  scope :packed, joins(:shop).where(shops: {pack: true})
  scope :separate, joins(:shop).where(shops: {pack: false})
  scope :recent, joins(:shop).order("shops.seen_time DESC")

  attr_accessible :item_id, :count, :price, :enchant

  def self.from_server(server)
    where(shops: {server_id: server.id})
  end

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
