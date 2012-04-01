class Product
  include Mongoid::Document

  embedded_in :shop

  field :item_id, :type => Integer
  field :count, :type => Integer
  field :price, :type => Integer
  field :enchant, :type => Integer

  def item
    Item.find(item_id)
  end
end
