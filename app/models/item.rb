class Item
  CACHED = YAML::load(File.open(Rails.root.join('static', 'items.yml')))
end
