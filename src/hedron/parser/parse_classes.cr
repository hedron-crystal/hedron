require "../widget/*"

module Hedron
  private class Parsed
    property widget : Widget
    property id : String
    getter children : Array(Parsed)
    getter aliases = {} of String => Array(String)

    def initialize(@id, @widget)
      @aliases[@id] = [] of String if @id[0] != '!'
      @children = [] of Parsed
    end

    def add_child(child : Parsed)
      if child.id[0] != '!'
        @aliases[child.id] = [] of String
      end

      child.aliases.keys.each do |key|
        @aliases[key] = [child.id] + child.aliases[key]
      end

      children.push(child)
    end
  end

  class Render
    @parsed : Parsed

    def initialize(@parsed); end

    def [](index : String) : Widget
      raise ArgumentError.new("No such widget with ID #{index}") unless @parsed.aliases.has_key?(index)
      
      path = @parsed.aliases[index]
      nested = @parsed

      path.each do |key|
        nested = nested.children.find { |child| child.id == key }.not_nil!
      end

      return nested.widget
    end

    def [](wclass : Widget.class) : Array(Widget)
      items = [] of Widget
      items.push(widget) if widget.class == wclass

      children.each do |child|
        items.merge!(self[wclass])
      end

      return items
    end
  end
end
