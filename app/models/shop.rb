class Shop < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  has_many :products

  attr_accessible :server_id, :player, :pack, :seen_time, :location
end
