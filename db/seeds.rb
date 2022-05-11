# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating products
p 'Creating products'
Product.delete_all if Product.all
Product.create(
  [
    {
      name: 'Medium Coverage',
      sell_in: 10,
      price: 20,
      created_at: '15/05/2022'
    },
    {
      name: 'Full Coverage',
      sell_in: 2,
      price: 0,
      created_at: '20/05/2022'
    },
    {
      name: 'Low Coverage',
      sell_in: 5,
      price: 7,
      created_at: '1/06/2022'
    },
    {
      name: 'Mega Coverage',
      sell_in: 0,
      price: 80,
      created_at: '15/05/2022'
    },
    {
      name: 'Mega Coverage',
      sell_in: -1,
      price: 80
    },
    {
      name: 'Special Full Coverage',
      sell_in: 15,
      price: 20
    },
    {
      name: 'Special Full Coverage',
      sell_in: 10,
      price: 49,
      created_at: '15/05/2022'
    },
    {
      name: 'Special Full Coverage',
      sell_in: 5,
      price: 49
    },
    {
      name: 'Super Sale',
      sell_in: 3,
      price: 6
    }
  ]
)
p "Product count: #{Product.all.count}"
