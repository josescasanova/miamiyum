# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

merchant = Merchant.create(name: 'Champs', address: '11641 sw 98 street', locality: 'miami', region: 'FL', postal_code: '33176', latitude: 25.67821, longitude: -80.36663)
deal = Deal.create(deal_title: '50% off Champs', category: 'restaurant', deal_url: '#', image_url: '#', expires_at: '01012020', price: 999, value: 1999, merchant: merchant)
