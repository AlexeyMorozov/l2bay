class Shop < ActiveRecord::Base
  has_many :products

  attr_accessible :server_id, :player, :pack, :seen_time, :location
end
