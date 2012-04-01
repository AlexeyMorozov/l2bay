class Product
  include Mongoid::Document

  field :player
  field :item_id, :type => Integer
  field :count, :type => Integer
  field :price, :type => Integer
  field :is_package_sale, :type => Boolean
  field :seen_time, :type => Time
  field :enchant, :type => Integer
end
