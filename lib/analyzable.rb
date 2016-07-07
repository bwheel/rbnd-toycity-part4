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
    # counts by brand, 
    # counts by name
  end
end

