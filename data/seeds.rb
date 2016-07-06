require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  brands = Faker::Commerce.product_name
  product_names = Faker::Name.name 
  prices = Faker::Commerce.price

  10.times do
    Product.create( brand: brands.sample,
                    name: product_names.sample,
                    price: prices.sample)
  end
end
