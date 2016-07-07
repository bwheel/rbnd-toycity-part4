class Module
  def create_finder_methods(*attributes)
    attributes.flatten!
    attributes.each do |attribute|
      instance_eval %Q(
        def self.find_by_#{attribute}(attribute_search_phrase)
          all.select { |item| item.#{attribute} == attribute_search_phrase }.first
        end
      )
    end
  end
end
