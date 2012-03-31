class Item
  extend ActiveModel::Naming

  @@cached = YAML::load(File.open(Rails.root.join('static', 'items.yml'), 'r')) if File.exists?(Rails.root.join('static', 'items.yml'))

  attr_accessor :id, :name, :sa

  def self.find(*ids)
    expects_array = ids.first.kind_of?(Array)
    return ids.first if expects_array && ids.first.empty?

    ids = ids.flatten.compact.uniq

    case ids.size
    when 0
      raise ActiveRecord::RecordNotFound, "Couldn't find Item without an ID"
    when 1
      result = find_one(ids.first)
      expects_array ? [ result ] : result
    else
      find_some(ids)
    end
  end

  def self.search(query)
    sphinx_res = Thebes::Query.run {|q| q.append_query query, 'items'}
    ids = sphinx_res[0][:matches].map {|match| match[:doc]}
    find(ids)
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_param
    @id
  end

  private

  def self.find_one(id)
    @@cached[id.to_i] || raise(ActiveRecord::RecordNotFound)
  end

  def self.find_some(ids)
   ids.map {|id| find_one(id)}
  end
end
