class Account < ActiveRecord::Base
  attr_accessible :points, :user_id
end
