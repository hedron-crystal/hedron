require "./widget/widget.cr"

module Hedron
  class Render
    property widget : Widget
    getter children : Hash(String, Render)
    getter aliases = {} of String => Array(String)

    def initialize(@widget)
      id = @widget.id.not_nil!
      @aliases[id] = [] of String if id[0] != '!'
      @children = {} of String => Render
    end

    def add_child(child : Render)
      id = child.widget.id.not_nil!

      @aliases[id] = [] of String if id[0] != '!'

      child.aliases.keys.each do |key|
        @aliases[key] = [id] + child.aliases[key]
      end

      @children[id] = child
    end

    def [](id : String) : Render
      raise ArgumentError.new("Invalid ID: #{id}") unless id.match(/[a-z\-]+/)
      raise ArgumentError.new("No such widget with ID #{id}") unless @aliases.has_key?(id)
      
      path = @aliases[id]
      nested = self

      path.each do |key|
        nested = nested.children[key]
      end

      return nested
    end

    def [](wclass : Widget.class) : Array(Render)
      items = [] of Render
      items.push(self) if @widget.class == wclass

      @children.each do |child|
        items.merge!(child[wclass])
      end

      return items
    end
  end
end
