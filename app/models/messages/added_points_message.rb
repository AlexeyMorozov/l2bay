class AddedPointsMessage < Message
  LOG_TYPE = 1

  def self.format
    {
      server_id: 'L',
      count: 'L',
      shops_accepted: 'L',
      new_points: 'Q',
      given_points: 'Q',
    }
  end
  format.keys.each { |a| attr_accessor a }

  def title
    "Added ponts"
  end

  def description
    server_name = Server.find(server_id).name
    <<-EOS
Earned #{given_points} points. Accepted shops: #{shops_accepted}. \
Total shops: #{count}. Server: #{server_name}. Total points: #{new_points}.
    EOS
  end
end
