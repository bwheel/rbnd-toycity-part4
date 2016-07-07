require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  
  def self.create(attributes = nil)

    # create new instance of item.
    item = self.new(attributes)

    # save to database.
    save_item_to_database item
    
    # return the item.
    item
  end

  def self.all
    # returns the array of the product objects .
    get_data_from_database.to_a().drop(1).map { |item| self.new( :id => item[0].to_i, :brand => item[1], :name => item[2], :price => item[3].to_f) }
  end

  def self.first(index = nil)
    #returns the first object in the array of product objects.
    # if there is an index it returns the first item(s) as an array. 
    index == nil ? all.first() : all.first(index)
    
  end

  def self.last(index = nil)
    #returns the last object in the array of product objects.
    # if there is an index it returns the last item(s) as an array. 
    index == nil ? all.last() : all.last(index)
  end

  def self.find(id)
    # returns the object at the index passed in.
    # raises a (ProductNotFoundError) if not found in database
    result_items = all.select { |item| item.id == id}
    if result_items.empty?
      raise ProductNotFoundError, "The product with id: #{id} was not found in database"
    else
      result_items.first
    end
  end

  def create_find_by_attributes
    # use metaprogramming to define a find_by_{attribute} function
    # call this function at the bottom of this file.
  end

  def self.destroy(id)
    # destroys the product with the i passed in from the database.
    # raises an error (ProductNotFoundError) if not in database.
    deleted_items = all.select {|item| item.id == id}
    if deleted_items.empty?
      raise ProductNotFoundError, "The product with id: #{id} was not found in database"
    else
      all.delete(deleted_items.first)
      deleted_items.first
    end
  end

  def self.where(filters)
    # this function will return an array of products.
    # it will pass in filters of attributes to search by in the form of a hash
    # filters ex:
    #     {:brand => "lego"}
  end

  def update(updates)
    #This is an instance function that will update a givien product
    # depending on the attributes in the updates hash
  end

  private

  def self.get_data_from_database
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.read(data_path, :headers => :first_row)
  end

  def self.save_item_to_database(item)
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(data_path, "a+") do |cvs|
      cvs << [item.id, item.brand, item.name, item.price]
    end
  end
end
