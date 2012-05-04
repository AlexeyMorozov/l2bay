module ItemsHelper
  def server_options
    server_urls = Server.all.map {|s| [s.name, change_server_link(s)]}
    options_for_select(server_urls, change_server_link)
  end

  def products_block(products, heading)
    if products.count > 0
      @products_found = true
      content_tag(:h2, heading) + render(partial: 'products', locals: {products: products})
    end
  end

  def products_found?
    @products_found
  end

  def has_enchant?(products)
    products.detect { |p| p.enchant.present? && p.enchant != 0 }
  end

  private

  def change_server_link(server = current_server)
    url_for(params.merge(server: server, page:nil))
  end
end
