require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed

  10.times do

    brands = Faker::Commerce.product_name
    product_names = Faker::Name.name 
    prices = Faker::Commerce.price

    Product.create( brand: brands,
                    name: product_names,
                    price: prices)
  end
end
