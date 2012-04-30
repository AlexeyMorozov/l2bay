module ItemsHelper
  def server_options
    server_urls = Server.all.map {|s| [s.name, url_for(server: s)]}
    options_for_select(server_urls, url_for(server: current_server))
  end
end
