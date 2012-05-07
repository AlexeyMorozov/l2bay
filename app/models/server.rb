class Server < ActiveRecord::Base
  establish_connection "game_#{Rails.env}"

  has_many :shops

  attr_accessible :name

  def to_param
    name.parameterize
  end
end
