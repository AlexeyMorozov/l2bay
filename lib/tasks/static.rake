namespace :static do
  namespace :generate do
    desc 'Generate in-game items data from a csv file specified with CSV=(/path/to/csv)'
    task :items => :environment do
      raise "CSV variable is not set" if ENV['CSV'].blank?
      items = {}
      File.open(ENV['CSV'], 'r') do |csv|
        csv.read.each_line do |item|
          id, name, sa = item.chomp.split(%r{\u0001|\u0002})
          id = id.to_i
          items[id] = Item.new({ id: id, name: name, sa: sa })
        end
      end
      File.open(Rails.root.join('static', 'items.yml'), 'w').write(YAML.dump(items))
    end
  end
end
