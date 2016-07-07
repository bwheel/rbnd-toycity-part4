module Analyzable
  def count_by_brand (*products)
    # retuns a hash with inventory counts, organized by brand.
  end

  def count_by_name(*products)
    # should return a hash with inventory counts, organized by product name    
  end

  def average_price(*products)
    products.flatten!
    (products.inject(0) {|sum,p| sum + p.price} / products.length ).round(2)
  end

  def print_report(*products)
    # returns summary inventory report containing :
    
    # average price
    puts "Average price:$#{products}"
    
    # counts by brand, 
    by_brand = count_by_brand(products)
    by_brand.each do |brand, count|
      puts "\t- #{brand}: #{count}"
    end

    # counts by name
    by_name = count_by_name(products)
    by_name.each do |name, count|
      puts "\t- #{name}: #{count}"
    end
  end
end

