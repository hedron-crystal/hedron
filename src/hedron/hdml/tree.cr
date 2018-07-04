require "../any.cr"

module Hedron::HDML
  private class TemporaryID
    @@counter = -1

    def self.new_id
      @@counter += 1
      return "!#{@@counter}"
    end
  end

  private class Tree
    @@counter = 0

    property node_class : String
    property id : String
    property index : String?
    property values : Hash(String, Any)
    property leaves : Array(Tree)

    def initialize(@node_class, @id)
      @index = nil
      @values = {} of String => Any
      @leaves = [] of Tree
    end

    def initialize(@node_class)
      @id = TemporaryID.new_id
      @index = nil
      @values = {} of String => Any
      @leaves = [] of Tree
    end

    def [](index : String)
      return leaves.select { |leaf| leaf.id == index }[0]
    end
  end
end
