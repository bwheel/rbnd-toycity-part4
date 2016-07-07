module Analyzable
  #def count_by_brand (*products)
  #  # retuns a hash with inventory counts, organized by brand.
  #  products.flatten!
  #  results = {}
  #  products.each do |product|
  #    results[product.brand] += 1
  #  end
  #
  #  results
  #end

 # def count_by_name(*products)
    # should return a hash with inventory counts, organized by product name    
 # end

  def create_count_by_methods(*attributes)
    attributes.flatten!
    attributes.each do |attribute|
      instance_eval %Q(
        def count_by_#{attribute}(*products)
          products.flatten!
          results = {}
          products.each do |product|
            results[product.#{attribute}] = results[product.#{attribute}] != nil ? results[product.#{attribute}] + 1 : 1 
          end
          results
        end
      )
    end
  end
  #def count_by_name(*products)
  #    products.flatten!
  #    results = {}
  #    products.each do |product|
  #      results[product.name]=  (results[product.name] != nil) ? results[product.name] + 1 : 1
  #     end
  #    results
  #end

  def average_price(*products)
    products.flatten!
    (products.inject(0) {|sum,p| sum + p.price} / products.length ).round(2)
  end

  def print_report(*products)
    # returns summary inventory report containing :
    
    # average price
    report = "Average price:$#{average_price(products)}\n"
    
    # counts by brand, 
    report << "Inventory by Brand:"
    by_brand = count_by_brand(products)
    by_brand.each do |brand, count|
      report << "\t- #{brand}: #{count}\n"
    end

    # counts by name
    report << "Inventory by Name:\n"
    by_name = count_by_name(products)
    by_name.each do |name, count|
      report << "\t- #{name}: #{count}\n"
    end

    puts report
  end
end

