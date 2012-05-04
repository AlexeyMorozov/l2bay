namespace :dev do
  task :seed => :environment do
    Shop.delete_all
    Product.delete_all
    ActiveRecord::Base.transaction do
      5.times { |i| Shop.create!({
        server_id: Server.first.id, player: "Aragorn#{i}", pack: false, sell: (i % 2 == 0 ? true : false), seen_time: Time.zone.now - 1.hour, loc_x: 1, loc_y: 2, loc_z: 3
      }).products.create([
        {item_id: 6608, count: 1, price: 87000100, enchant: 1},
        {item_id: 7575, count: 1, price: 287020400, enchant: 2},
        {item_id: 7575, count: 1, price: 1, enchant: 16},
      ]) }
      Shop.create!({
        server_id: Server.first.id, player: 'Legolas', pack: true, sell: true, seen_time: Time.zone.now - 2.hour, loc_x: 4, loc_y: 5, loc_z: 6
      }).products.create([
        {item_id: 7575, count: 1, price: 401000200, enchant: 5},
        {item_id: 7575, count: 1, price: 401000200, enchant: 5},
      ])
      Shop.create!({
        server_id: Server.last.id, player: 'Gimli', pack: false, sell: true, seen_time: Time.zone.now - 1.day, loc_x: 7, loc_y: 7, loc_z: 7
      }).products.create([
        {item_id: 7575, count: 1, price: 300020400, enchant: 3},
        {item_id: 1463, count: 50, price: 1001, enchant: 0},
        {item_id: 1804, count: 5, price: 100001001, enchant: 0},
      ])
    end
  end
end

