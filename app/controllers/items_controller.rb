class ItemsController < ApplicationController
  def index
    sphinx_res = Thebes::Query.run do |a|
      a.match_mode = :extended
      a.append_query 'acumen', 'items'
    end
    raise sphinx_res.to_yaml
  end
end
