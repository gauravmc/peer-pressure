# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
shop = Shop.create(
  domain: 'gauravtesting.myshopify.com',
  name: 'Torque',
  owner: 'Gaurav Chande',
  token: 'c4d48141fee20750f6b4b2d9fa09fdc5',
  remote_id: 1605628
)

ducati = Product.create(
  title: 'Ducati 848 Evo',
  img_url: 'http://cdn.shopify.com/s/files/1/0160/5628/products/SBK-848evo_2011_Studio_W_C01S_1620x10803-2.mediagallery_output_image_1920x1080.png?316',
  handle: 'ducati-848-evo',
  shop: shop,
  remote_id: 93081028
)

kawasaki = Product.create(
  title: 'Kawasaki Ninja 250R',
  img_url: 'http://cdn.shopify.com/s/files/1/0160/5628/products/Green2010Ninja250RSpecialEditionside.jpeg?318',
  handle: 'kawasaki-ninja-250r',
  shop: shop,
  remote_id: 97321566
)

yamaha = Product.create(
  title: 'Yamaha R6',
  img_url: 'http://cdn.shopify.com/s/files/1/0160/5628/products/r6.jpeg?318',
  handle: 'yamaha-r6',
  shop: shop,
  remote_id: 98349284
)

[ducati, kawasaki, yamaha].each do |product|
  SoldItem.create(
    product: product,
    shop: shop,
    quantity: 1
  )
end