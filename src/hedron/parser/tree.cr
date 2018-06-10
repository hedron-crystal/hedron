require "./any.cr"

module Hedron
  private class Tree
    @@counter = 0

    property index : String?
    property node_class : String
    property id : String
    property values : Hash(String, Any)
    property leaves : Array(Tree)

    def initialize(@node_class, @id)
      @index = nil
      @values = {} of String => Any
      @leaves = [] of Tree
    end

    def initialize(@node_class)
      @index = nil
      @id = "!#{@@counter}"
      @values = {} of String => Any
      @leaves = [] of Tree

      @@counter += 1
    end

    def [](index : String)
      return leaves.select { |leaf| leaf.id == index }[0]
    end
  end
end
