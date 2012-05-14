servers = {
  'Chronos' => '64.25.37.132',
  'Naia' => '64.25.37.133',
  'Shilen' => '64.25.37.134',
  'Magmeld' => '64.25.37.135',
  'Bartz' => '64.25.37.136',
}
servers.each do |name, ip|
  s = Server.find_or_initialize_by_name(name)
  s.ip = ip
  s.save!
end
