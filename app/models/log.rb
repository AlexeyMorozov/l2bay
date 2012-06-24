class Log < ActiveRecord::Base
  belongs_to :user

  attr_accessible :data, :log_type, :user_id

  Message = Struct.new(:title, :fields)
  MessageField = Struct.new(:type, :title) do
    def get_value(value)
      value
    end
  end
  class ServerField < MessageField
    def get_value(value)
      Server.find(value).name
    end
  end
  @@messages = {
      1 => Message.new('Added points', [
          ServerField.new('L', 'Server'),
          MessageField.new('L', 'Total shops'),
          MessageField.new('L', 'Accepted shops'),
          MessageField.new('Q', 'Total points'),
          MessageField.new('Q', 'Earned points'),
      ]),
  }

  def title
    message.title
  end

  def description
    format = message.fields.map { |f| f.type }.join
    values = data.unpack(format)
    messages = message.fields.zip(values).map do |field, value|
      "#{field.title}: #{field.get_value(value)}."
    end
    messages.join(' ')
  end

  private

  def message
    @@messages[log_type]
  end
end
