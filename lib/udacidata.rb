require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  
  def self.create(attributes = nil)
    # If the object's data is already in the database
    # create the object
    # return the object

    # If the object's data is not in the database
    # create the object
    # save the data in the database
    # return the object
  end

  def self.all
    # returns the array of the product objects .
  end

  def self.first(index = nil)
    #returns the first object in the array of product objects.
    # if there is an index it returns the first item(s) as an array. 
    # index may be off by one.
  end

  def self.last(index = nil)
    #returns the last object in the array of product objects.
    # if there is an index it returns the last item(s) as an array. 
    # index may be off by one.
  end

  def self.find(index)
    # returns the object at the index passed in.
    # raises a (ProductNotFoundError) if not found in database
  end

  def create_find_by_attributes
    # use metaprogramming to define a find_by_{attribute} function
    # call this function at the bottom of this file.
  end

  def self.destroy(id)
    # destroys the product with the i passed in from the database.
    # raises an error (ProductNotFoundError) if not in database.
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

end
