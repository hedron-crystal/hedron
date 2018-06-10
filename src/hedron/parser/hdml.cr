require "./lexer.cr"
require "./parser.cr"

module Hedron
  class HDML
    @@parser = Parser.new

    def self.render_file(filename : String) : Render
      return Render.new(@@parser.parse_tree(Lexer.lex(filename)))
    end

    def self.create_widget(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Tree)?) : Tree
      return @@parser.to_tree(class_name, id, index, values, children)
    end

    def self.render(tree : Tree) : Render
      return Render.new(@@parser.parse_from_render(tree))
    end

    def self.add_class(wclass : Widget.class)
      @@parser.add_class(wclass)
    end
  end
end
