class String

  def upcase_first
    letters = self.split('')
  	letters.first.upcase!
  	letters.join
  end

  def lowercase_first
    letters = self.split('')
  	letters.first.downcase!
  	letters.join
     letters.join
  end

end

class Helpers

    def self.recursiveAttributes(entity)
      attributes = Array.new
      entity.attributes.each do |a|
        attributes.push(a)
      end
      if entity.parent != nil
        inherited_attributes = self.recursiveAttributes(entity.parent)
        inherited_attributes.each do |a|
          attributes.push(a)
        end
      end
      return attributes.sort_by { |attr| attr.name }
    end

    def self.recursiveRealtionships(entity)
      relationships = Array.new
      entity.relationships.each do |r|
        relationships.push(r)
      end
      if entity.parent != nil
        inherited_relationships = self.recursiveRealtionships(entity.parent)
        inherited_relationships.each do |a|
          relationships.push(a)
        end
      end
      return relationships.sort_by { |rel| rel.name }
    end
    
end