module ItemsHelper
  def server_options
    server_urls = Server.all.map {|s| [s.name, change_server_link(s)]}
    options_for_select(server_urls, change_server_link)
  end

  def has_enchant?(products)
    products.detect { |p| p.enchant.present? && p.enchant != 0 }
  end

  private

  def change_server_link(server = current_server)
    url_for(params.merge(server: server, page:nil))
  end
end
