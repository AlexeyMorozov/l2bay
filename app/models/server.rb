class Server < ActiveRecord::Base
  attr_accessible :name

  def to_param
    name.parameterize
  end
end
