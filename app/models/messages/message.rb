class Message
  include ActionView::Helpers::TextHelper

  MESSAGES = [
    AddedPointsMessage,
  ]

  def self.create(type)
    m = MESSAGES.detect { |m| m::LOG_TYPE == type }
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
