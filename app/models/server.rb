require 'ipaddr'

class Server < GameDb
  has_many :shops

  attr_accessible :name, :ip

  def ip=(ip)
    ip = IPAddr.new(ip).to_i if ip.to_s.include? '.'
    write_attribute(:ip, ip)
  end

  def to_param
    name.parameterize
  end
end
