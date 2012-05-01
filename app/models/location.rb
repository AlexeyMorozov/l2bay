class Location
  @@cache_file = Rails.root.join('static', 'locations.yml')
  @@cached = YAML::load(File.open(@@cache_file, 'r')) if File.exists?(@@cache_file)

  RADIUS_SQUARE = 15000 ** 2

  attr_accessor :name, :x, :y, :z

  def self.find_by_coords(x, y, z)
    @@cached.detect { |l| distance_square(l.x, l.y, x, y) < RADIUS_SQUARE }
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  private

  def self.distance_square(foo_x, foo_y, bar_x, bar_y)
    (foo_x - bar_x)**2 + (foo_y - bar_y)**2
  end
end
