# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create([{name: 'Produce'}, {name: 'Deli'}, {name: 'Bread'}, {name: 'Baking'}, {name: 'Condiments'}, {name: 'Dairy'}, {name: 'Frozen'}, {name: 'Meat'}, {name: 'Fish'}, {name: 'Canned'}, {name: 'Foreign'}, {name: 'Cleaning'}, {name: 'Toiletries'}, {name: 'Paper'}, {name: 'Misc'}])

stores = Store.create([{name: 'Giant Eagle'}, {name: 'Target'}, {name: 'Rite Aid'}, {name: 'Ace'} ])

dairy = Category.find_by_name('Dairy')
deli = Category.find_by_name('Deli')
giant_eagle = Store.find_by_name('Giant Eagle')
target = Store.find_by_name('Target')


milk = Item.create!(name: 'milk', brand_name: 'Turners', quantity: '1 gallon', frequency: 'weekly', purchased: false, category_id: dairy.id)

turkey = Item.create(name: 'turkey', brand_name: 'Market District Lite', quantity: '1 pound', purchased: false, frequency: 'weekly', category_id: deli.id)

orange_juice = Item.create(name: 'OJ', brand_name: 'Tropicana Pulpy', quantity: '1/2 gallon', purchased: false, frequency: 'biweekly')

chips = Item.create(name: 'tortilla chips', purchased: false, frequency: 'weekly')

cheddar = Item.create(name: 'Sharp Cheddar', brand_name: 'Cracker Barrel Sharp White', quantity: '1 rectangle', purchased: false, frequency: 'weekly', category_id: dairy.id)

yogurt = Item.create(name: 'Plain Greek yogurt', brand_name: 'Fage', quantity: '1000 ml', purchased: false, frequency: 'weekly', category_id: dairy.id, note: '2% milkfat')

ItemStore.create(store: giant_eagle, item: milk)
ItemStore.create(store: target, item: yogurt)
ItemStore.create(store: giant_eagle, item: yogurt)
ItemStore.create(store: target, item: chips)
ItemStore.create(store: giant_eagle, item: chips)
