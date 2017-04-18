DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

admin = User.create!(username: 'admin',
                     email: 'admin@admin.com',
                     password: 'admin',
                     password_confirmation: 'admin')
user = User.create!(username: 'user',
                    email: 'user@user.com',
                    password: 'user',
                    password_confirmation: 'user')

puts 'Users created'

Category.create!(name: 'humble')
Category.create!(name: 'regal')
Category.create!(name: 'untrustworthy')

puts 'Categories created'

Creature.create!(breed: 'Bab Finch',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'bab-finch.jpg')
Creature.create!(breed: 'Llama Bun',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'bama.jpeg')
Creature.create!(breed: 'Camel Retriever',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'camel-retriever.jpg')
Creature.create!(breed: 'Teagle',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'eagle-terrier.jpg')
Creature.create!(breed: 'Quackaphant',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'ele-duck.jpg')
Creature.create!(breed: 'Frig',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'frig.jpg')
Creature.create!(breed: 'Crog',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'frog-o-dile.jpg')
Creature.create!(breed: 'Scrog',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'frog-pion.jpg')
Creature.create!(breed: 'Gorillaphant',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'gorillaphant.jpg')
Creature.create!(breed: 'Guinea Lion',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'guinea-lion.jpg')
Creature.create!(breed: 'Hork',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'hork.jpg')
Creature.create!(breed: 'Cowgaroo',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'kow.jpeg')
Creature.create!(breed: 'Lion Jacket',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'lion-jacket.jpg')
Creature.create!(breed: 'Elezard',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'lizardphant.jpg')
Creature.create!(breed: 'Pig Bull',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'pig-bull.jpg')
Creature.create!(breed: 'Chig',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'pimp.jpg')
Creature.create!(breed: 'Pugrilla',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'pugrilla.jpg')
Creature.create!(breed: 'Punny',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'punny.jpg')
Creature.create!(breed: 'Rhinaroo',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'rhinaroo.jpeg')
Creature.create!(breed: 'Shat',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'shark-cat.jpg')
Creature.create!(breed: 'Sharkopotamus',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'sharkopotamus.jpg')
Creature.create!(breed: 'Sherbil',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'sherbil.jpg')
Creature.create!(breed: 'Durtle',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'tort-duck.jpg')
Creature.create!(breed: 'Ursadile',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'ursadile.jpg')
Creature.create!(breed: 'Zebrocerous',
                 description: 'Wild and free',
                 price: (rand(75) + 10).to_s,
                 image_url: 'zebrocerous.jpg')

Creature.all.each do |creature|
  creature.categories << Category.all.sample
end

puts 'Creatures associated with a category'

STATUSES = %w(ordered paid cancelled completed)
10.times do
  admin.orders.create!(total: rand(1000) + 1,
                       status: STATUSES.sample)
  user.orders.create!(total: rand(1000) + 1,
                      status: STATUSES.sample)
end

puts 'Orders created'

100.times do
  OrderCreature.create!(order: Order.all.sample,
                        creature: Creature.all.sample,
                        quantity: rand(5) + 1)
end

puts 'OrderCreatures created'
