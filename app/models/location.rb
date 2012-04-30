class Location
  @@cache_file = Rails.root.join('static', 'locations.yml')
  @@cached = YAML::load(File.open(@@cache_file, 'r')) if File.exists?(@@cache_file)

  SQUARE_OF_MAX_DISTANCE_TO_BE_CONSIDERED_IN_TOWN = 15000 ** 2

  attr_accessor :name, :x, :y, :z

  def self.find_by_coords(x, y, z)
    loc = @@cached.detect { |l| distance_square(l.x, l.y, x, y) < SQUARE_OF_MAX_DISTANCE_TO_BE_CONSIDERED_IN_TOWN }
    loc || Location.new({name: 'Look coords', x: x, y: y, z: z})
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
