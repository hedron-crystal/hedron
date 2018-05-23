require "../widget/*"

module Hedron
  class Parsed
    property items : Hash(String, Widget)

    def initialize
      @items = {} of String => Widget
    end

    def [](index : String)
      raise UIError.new("Cannot access index #{index}") if index.match(/[a-z_]+/).nil?
      return items[index]
    end
  end

  private class NestedParsed
    property id : String
    property widget : Widget
    property children : Array(NestedParsed)

    def initialize(@id, @widget)
      @children = [] of NestedParsed
    end
  end
end