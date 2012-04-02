class Shop
  include Mongoid::Document

  field :player, :type => String
  field :pack, :type => Boolean
  field :seen_time, :type => Time
  field :location, :type => String

  embeds_many :products

  index(
    [
      [ 'products.item_id', Mongo::ASCENDING ],
      [ :seen_time, Mongo::DESCENDING ]
    ]
  )
end
