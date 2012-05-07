module ItemsHelper
  def server_options
    server_urls = Server.all.map {|s| [s.name, change_server_link(s)]}
    options_for_select(server_urls, change_server_link)
  end

  def being_sold(products)
    products.select { |p| p.shop.sell }
  end

  def being_bought(products)
    products.select { |p| !p.shop.sell }
  end

  def product_block(products, heading)
    if products.count > 0
      @products_found = true
      content_tag(:h2, heading) << render(partial: 'products', locals: {products: products})
    end
  end

  def pack_block(packs, heading, visible_item)
    if packs.count > 0
      @products_found = true
      content_tag(:h2, heading) << render(partial: 'packs', locals: {packs: packs, visible_item: visible_item})
    end
  end

  def visible_products(products, visible_item)
    products.select { |p| p.item.id == visible_item.id }.map { |p| yield p }.join($\).html_safe
  end

  def hidden_products(products, visible_item)
    products.select { |p| p.item.id != visible_item.id }.map { |p| yield p }.join($\).html_safe
  end

  def products_found?
    @products_found
  end

  def has_enchant?(products)
    products.detect { |p| p.enchant.present? && p.enchant != 0 }
  end

  def price(price)
    content_tag :abbr, title: number_with_delimiter(price, delimiter: ' ') do
      number_to_human price, units: :common
    end
  end

  private

  def change_server_link(server = current_server)
    url_for(params.merge(server: server, page:nil))
  end
end
