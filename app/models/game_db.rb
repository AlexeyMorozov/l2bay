class GameDb < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "game_#{Rails.env}"
end
