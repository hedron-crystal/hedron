require "../../reader/any.cr"
require "./control.cr"

module Hedron
  alias MLArgs = Hash(String, Any)

  abstract class Widget
    property parent : Widget?

    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with arguments has not been implemented")
    end

    def self.widget_name : String
      return self.name.split("::")[-1]
    end

    macro gen_attributes(attrs)
      {% begin %}
        case key
        {% for key, val in attrs %}
          when {{key}}
            self.{{key.id}} = value.as({{val}})
        {% end %}
          else
            raise ParseError.new("No such attribute: #{key}")
        end
      {% end %}
    end

    def set_attribute(key : String, value : Any)
      raise ParseError.new("Widget does not have any attributes")
    end

    def parent?(widget : Widget) : Bool
      return @parent == widget
    end

    abstract def display : Control
  end

  abstract class SingleContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with arguments has not been implemented")
    end

    abstract def child=(child : Control)
  end

  abstract class MultipleContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with arguments has not been implemented")
    end

    abstract def add(child : Control)
  end

  abstract class IndexedContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with arguments has not been implemented")
    end

    abstract def []=(index : String, child : Control)
  end
end
