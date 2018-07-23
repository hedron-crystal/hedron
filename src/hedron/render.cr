require "./widget/widget.cr"

module Hedron
  # The `Render` class is the data type returned when
  # a markup file or string with HDML in it is evaluated.
  # Allows the user to fetch specific widgets from HDML based
  # on ID or class.
  class Render
    property widget : Widget
    getter children : Hash(String, Render)
    getter aliases = {} of String => Array(String)

    def initialize(@widget)
      @aliases[@widget.id] = [] of String if @widget.id[0] != '!'
      @children = {} of String => Render
    end

    # :no-doc:
    def add_child(child : Render)
      id = child.widget.id

      @aliases[id] = [] of String if id[0] != '!'

      child.aliases.keys.each do |key|
        @aliases[key] = [id] + child.aliases[key]
      end

      @children[id] = child
    end

    # Fetches a widget from rendered HDML based on ID.
    # For example, if `foo.hdml` looked like this:
    #
    # ```
    # Button #button {
    #   @text: "Hello, World!";
    # }
    # ```
    #
    # You can fetch `#button` by doing this:
    #
    # ```crystal
    # foo = Hedron::HDML.render_file("foo.hdml")
    # foo["button"]
    # ```
    def [](id : String) : Widget
      raise ArgumentError.new("Invalid ID: #{id}") unless id.match(/[a-z\-]+/)
      raise ArgumentError.new("No such widget with ID #{id}") unless @aliases.has_key?(id)

      path = @aliases[id]
      nested = self

      path.each do |key|
        nested = nested.children[key]
      end

      return nested.widget
    end

    # Fetches all widgets from rendered HDML based on a class - all
    # widgets that share the same class as the one given will be returned.
    #
    # For example, if `foo.hdml` looked like this:
    # ```
    # VerticalBox {
    #   Button #b1 {
    #     @text: "Button 1";
    #   }
    #
    #   Button #b2 {
    #     @text: "Button 2";
    #   }
    # }
    # ```
    #
    # You can do this to access all buttons in `foo.hdml`:
    # ```crystal
    # foo = Hedron::HDML.render_file("foo.hdml")
    # buttons = foo[Hedron::Button]
    def [](wclass : Widget.class) : Array(Widget)
      items = [] of Render
      items.push(@widget) if @widget.class == wclass

      @children.each do |child|
        items.merge!(child[wclass])
      end

      return items
    end
  end
end
