class Item
  extend ActiveModel::Naming

  @@cache_file = Rails.root.join('static', 'items.yml')
  @@cached = YAML::load(File.open(@@cache_file, 'r')) if File.exists?(@@cache_file)

  attr_accessor :id, :name, :sa, :position_by_name

  def products
    Product.where(item_id: id)
  end

  def shops
    Shop.joins(:products).where(products: { item_id: id })
  end

  def self.unknown_item(id)
    Item.new({ id: id, name: 'Unknown item', sa: '' })
  end

  def self.all
    @@cached.values
  end

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

  def self.paginated_search(query, options = {})
    page = (options[:page] || 1).to_i
    per_page = (options[:per_page] || 10).to_i
    WillPaginate::Collection.create(page, per_page) do |pager|
      sphinx_res = sphinx_search(query, {offset: pager.offset, limit: pager.per_page})
      ids = sphinx_res[:matches].map {|m| m[:doc]}
      pager.replace(find(ids))
      pager.total_entries = sphinx_res[:total]
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_param
    id
  end

  def path_to_icon
    "items/#{id}.png"
  end

  def display_name
    str = name
    str << " [#{sa}]" if sa.present?
    str
  end

  private

    def self.find_one(id)
      @@cached[id.to_i] || unknown_item(id)
    end

    def self.find_some(ids)
      ids.map {|id| find_one(id)}.compact
    end

    def self.sphinx_search(query, options = {})
      client = Riddle::Client.new
      client.offset = options[:offset] if options[:offset]
      client.limit = options[:limit] if options[:limit]
      client.sort_mode = :extended
      client.sort_by = 'position_by_name ASC'
      client.query query, 'items'
    end
end
