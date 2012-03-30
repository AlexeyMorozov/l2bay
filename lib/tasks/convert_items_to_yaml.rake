task :convert_items_to_yaml => :environment do
  items = {}
  File.open(Rails.root.join('static', 'items.csv'), 'r') do |csv|
    csv.read.each_line do |item|
      id, name, sa = item.chomp.split(%r{\u0001|\u0002})
      id = id.to_i
      items[id] = Item.new({ id: id, name: name, sa: sa })
    end
  end
  File.open(Rails.root.join('static', 'items.yml'), 'w') {|f| f.write(YAML.dump(items)) }
end

