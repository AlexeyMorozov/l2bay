namespace :dev do
  task :seed => :environment do
    Shop.delete_all
    Product.delete_all
    shops_list = []
    [
      {player: 'Aragorn', pack: false, seen_time: Time.zone.now - 1.hour, location: 'Aden', products_attributes: [
        {item_id: 6608, count: 1, price: 87000100, enchant: 1},
      ]},
      {player: 'Legolas', pack: false, seen_time: Time.zone.now - 2.hour, location: 'Giran', products_attributes: [
        {item_id: 7575, count: 1, price: 287020400, enchant: 2},
        {item_id: 7575, count: 1, price: 401000200, enchant: 5},
      ]},
      {player: 'Gimli', pack: false, seen_time: Time.zone.now - 1.day, location: 'Rune', products_attributes: [
        {item_id: 7575, count: 1, price: 300020400, enchant: 3},
        {item_id: 1463, count: 50, price: 1001, enchant: 0},
        {item_id: 1804, count: 5, price: 100001001, enchant: 0},
      ]},
    ].each do |s|
        10.times {shops_list << s}
      end
      Shop.create!(shops_list)
  end
end
