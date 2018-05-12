require "../control/control.cr"
require "./widget.cr"

module Hedron
  abstract class SingleContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with args has not been implemented")
    end

    abstract def child=(child : Control)
  end

  abstract class MultipleContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with args has not been implemented")
    end

    abstract def add(child : Control)
  end

  abstract class IndexedContainer < Widget
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization with args has not been implemented")
    end

    abstract def []=(index : String, child : Control)
  end
end
