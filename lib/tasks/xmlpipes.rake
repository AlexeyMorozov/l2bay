namespace :xmlpipes do
  desc 'Output items data in xmlpipe2 format'
  task :items => :environment do
    erb = ERB.new(File.read(Rails.root.join('lib', 'templates', 'xmlpipes', 'items.xmlpipe2.erb')))
    items = Item.all
    puts erb.result(binding)
  end
end
