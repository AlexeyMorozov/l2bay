class Item
  extend ActiveModel::Naming

  @@cached = YAML::load(File.open(Rails.root.join('static', 'items.yml'), 'r')) if File.exists?(Rails.root.join('static', 'items.yml'))

  attr_accessor :id, :name, :sa

  def self.all
    @@cached.values
  end

  def self.find(id)
    @@cached[id.to_i] || raise(ActiveRecord::RecordNotFound)
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_param
    @id
  end
end
