class Shop < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  belongs_to :servers
  has_many :products

  scope :packed, where(pack: true)
  scope :recent, order("seen_time DESC")

  attr_accessible :server_id, :player, :pack, :sell, :seen_time, :loc_x, :loc_y, :loc_z

  def self.from_server(server)
    where(server_id: server.id)
  end

  def self.with_item(item)
    joins(:products).where(products: {item_id: item.id})
  end

  def location_name
    @location_name ||= Location.find_by_coords(loc_x, loc_y, loc_z).try(:name) || "<unnamed>"
  end

  def coordinates
    "#{loc_x} #{loc_y} #{loc_z}"
  end

  def price
    products.reduce(0) {|sum, product| sum + product.price}
  end
end
