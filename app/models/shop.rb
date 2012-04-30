class Shop < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  has_many :products

  attr_accessible :server_id, :player, :pack, :sell, :seen_time, :loc_x, :loc_y, :loc_z

  def location
    @location ||= Location.find_by_coords(loc_x, loc_y, loc_z)
  end
end
