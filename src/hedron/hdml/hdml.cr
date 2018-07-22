require "./lexer.cr"
require "./parser.cr"

# The `Hedron::HDML` module contains all the relevant functions
# to parse HDML, as well as evaluation and a systematic way of creating
# widgets in code, similar to `ReactJS`. Allows for HDML code to be injected
# into Crystal programs, allowing for easy interoperability.
module Hedron::HDML
  # Given a file's path relative to the point of execution, returns a `Render`
  # object containing various widgets.
  def self.render_file(filename : String) : Render
    return Parser.parse_tree(Lexer.lex(filename))
  end

  # Given a string containing valid HDML code, evaluates it and returns a `Render`
  # object.
  def self.render(contents : String) : Render
    return Parser.parse_tree(Lexer.lex_contents(contents))
  end

  # Creates a widget in a centralised matter, similar to `React.createElement` in `ReactJS`.
  # Returns a `Render` object.
  def self.create_widget(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Render)?) : Render
    return Parser.parse_from_render(class_name, id, index, values, children)
  end
end
