# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
  {name: 'Bar', tariff_rate: 0.15},
  {name: 'Beverage', tariff_rate: 0.10},
  {name: 'Biscuits', tariff_rate: 0.15},
  {name: 'Blends', tariff_rate: 0.07},
  {name: 'Candy', tariff_rate: 0.15},
  {name: 'Chips', tariff_rate: 0.07},
  {name: 'Chocolate', tariff_rate: 0.07},
  {name: 'Dried Fruits', tariff_rate: 0.15},
  {name: 'Nibbles', tariff_rate: 0.15},
  {name: 'Spread', tariff_rate: 0.08},
  {name: 'Cereal', tariff_rate: 0.15},
  {name: 'Protein Snacks', tariff_rate: 0.15},
  {name: 'Others', tariff_rate: 0.15}
])