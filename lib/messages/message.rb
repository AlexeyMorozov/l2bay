class Message
  include ActionView::Helpers::TextHelper

  def self.messages
    [
      AddedPointsMessage,
    ]
  end

  def self.create(type)
    m = messages.detect { |m| m::LOG_TYPE == type }
    m.new
  end

  def data=(data)
    values = data.unpack(self.class.format.values.join)
    attributes = Hash[self.class.format.keys.zip(values)]
    attributes.each do |k, v|
      send("#{k}=", v)
    end
  end

  def data
    data = ""
    self.class.format.each do |k, v|
      data << send(k).pack(v)
    end
    data
  end
end
