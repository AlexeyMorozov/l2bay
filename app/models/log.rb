class Log < ActiveRecord::Base
  belongs_to :user

  attr_accessible :data, :log_type, :user_id

  def title
    message.title
  end

  def description
    message.description
  end

  private

  def message
    m = Message.create(log_type)
    m.data = data
    m
  end
end
