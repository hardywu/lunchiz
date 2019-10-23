# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create email: 'admin@test.io', password: 'changeme'
user1 = User.create email: 'user1@test.io', password: 'changeme'
user2 = User.create email: 'user2@test.io', password: 'changeme'
user3 = User.create email: 'user3@test.io', password: 'changeme'
owner1 = Owner.create email: 'owner1@test.io', password: 'changeme'
owner2 = Owner.create email: 'owner2@test.io', password: 'changeme'
Owner.create email: 'owner3@test.io', password: 'changeme'

owner1.stores.create name: 'store one'
owner1.stores.create name: 'store two'
owner1.stores.create name: 'store three'

owner2.stores.create name: 'store 4'
owner2.stores.create name: 'store 5'

user1.reviews.create store: owner1.stores.first, rate: 2, comment: 'bad', date: '2017-01-01'
user2.reviews.create store: owner1.stores.first, rate: 5, comment: 'good', date: '2017-03-01'
user3.reviews.create store: owner1.stores.first, rate: 1, comment: 'bad', date: '2017-05-01'
