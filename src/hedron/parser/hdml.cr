require "./parser.cr"

module Hedron
  class HDML
    @@parser = Parser.new

    def self.render_file(filename : String) : Render
      return @@parser.parse(filename)
    end

    def self.render(wclass : Widget.class, id : String?, index : String?, props : Hash(String, Any)?, children : Array(Render))
      return @@parser.parse_from_render()
    end

    def self.add_class(wclass : Widget.class)
      @@parser.add_class(wclass)
    end
  end
end