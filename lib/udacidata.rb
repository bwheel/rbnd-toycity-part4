require_relative 'find_by'
require_relative 'errors'
require_relative 'analyzable'
require 'csv'

include Analyzable

class Udacidata
  
  def self.create(attributes = nil)
    #create_finder_methods :brand, :name
     
    # create new instance of item.
    item = self.new(attributes)
    
    # figure out what attributes we gotz
    attribute_labels = item.instance_variables.map {|attr| attr[1..-1]} || []

    # dynamically create find_by_XXX methods and count_by_xxx methods
    create_finder_methods attribute_labels
    Analyzable::create_count_by_methods attribute_labels

    # save to database.
    save_item_to_database item
    
    # return the item.
    item
  end

  ##############################################
  # returns the array of the product objects .
  # TODO: make this get from database dynamic based on attributes.
  def self.all
    get_data_from_database.to_a().drop(1).map { |item| self.new( :id => item[0].to_i, :brand => item[1], :name => item[2], :price => item[3].to_f) }
  end
  
  ##############################################
  #returns the first object in the array of product objects.
  # if there is an index it returns the first item(s) as an array.
  def self.first(index = nil) 
    index == nil ? all.first() : all.first(index)
  end
  
  ##############################################
  #returns the last object in the array of product objects.
  # if there is an index it returns the last item(s) as an array.
  def self.last(index = nil) 
    index == nil ? all.last() : all.last(index)
  end

  ##############################################
  # returns the object at the index passed in.
  # raises a (ProductNotFoundError) if not found in database
  def self.find(id)  
    result_items = all.select { |item| item.id == id}
    if result_items.empty?
      raise ProductNotFoundError, "The product with id: #{id} was not found in database"
    else
      result_items.first
    end
  end

  ##############################################
  # destroys the product with the i passed in from the database.
  # raises an error (ProductNotFoundError) if not in database.
  def self.destroy(id)
    deleted_items = all.select {|item| item.id == id}
    if deleted_items.empty?
      raise ProductNotFoundError, "The product with id: #{id} was not found in database"
    else
      all.delete(deleted_items.first)
        # get current CSV file.
        data_path = File.dirname(__FILE__) + "/../data/data.csv"
        table = CSV.table(data_path)
        # remove the row in the table variable.
        table.delete_if {|row| row[:id] == id }

        # overwrite the datafile.
        File.open(data_path, 'w') do |f|
          f.write(table.to_csv)
        end

      deleted_items.first
    end
  end

  ##############################################
  # this function will return an array of products.
  # it will pass in filters of attributes to search by in the form of a hash
  # filters ex:
  #     {:brand => "lego"}
  def self.where(filters)
    items = all
    result_items = items.select { |item| item.brand == filters[:brand] } if filters[:brand]
    result_items = items.select { |item| item.name == filters[:name] } if filters[:name]
    result_items
  end
  
  ##############################################
  #This is an instance function that will update a givien product
  # depending on the attributes in the updates hash
  def update(updates)
      @brand = updates[:brand] if updates[:brand]
      @name = updates[:name] if updates[:name]
      @price = updates[:price] if updates[:price]
      self.class.destroy(@id)
      self.class.create(:id => @id, :brand => @brand, :name => @name, :price => @price)
      self
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
