require "./lexer.cr"
require "./parser.cr"

module Hedron::HDML
  def self.render_file(filename : String) : Render
    return Parser.parse_tree(Lexer.lex(filename))
  end

  def self.render(contents : String) : Render
    return Parser.parse_tree(Lexer.lex_contents(contents))
  end

  def self.create_widget(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Render)?) : Render
    return Parser.parse_from_render(class_name, id, index, values, children)
  end
end
