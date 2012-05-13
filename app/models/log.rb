class Log < ActiveRecord::Base
  attr_accessible :data, :log_type, :user_id
end
