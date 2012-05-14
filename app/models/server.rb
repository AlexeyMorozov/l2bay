class Server < ActiveRecord::Base
  switch_connection_to :game

  has_many :shops

  attr_accessible :name

  def to_param
    name.parameterize
  end
end
