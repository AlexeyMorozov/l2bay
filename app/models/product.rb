class Product < ActiveRecord::Base
  belongs_to :shop

  def item
    Item.find(item_id)
  end
end
