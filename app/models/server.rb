class Server < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  attr_accessible :name

  def to_param
    name.parameterize
  end
end
