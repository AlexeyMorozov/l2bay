namespace :xmlpipes do
  desc 'Output items data in xmlpipe2 format'
  task :items => :environment do
    erb = ERB.new(File.read(Rails.root.join('lib', 'templates', 'xmlpipes', 'items.xmlpipe2.erb')))
    items = Item.all.sort_by { |i| i.display_name }
    items.each_with_index.map do |item, index|
      item.position_by_name = index
      item
    end
    puts erb.result(binding)
  end
end
