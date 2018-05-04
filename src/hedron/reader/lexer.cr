module Hedron
  class Tree
    @@counter = 0

    property node_type : String
    property id : String
    property values : Hash(String, String)
    property leaves : Array(Tree)

    def initialize(@node_type, @id)
      @values = {} of String => String
      @leaves = [] of Tree
    end

    def initialize(@node_type)
      @id = "##{@@counter}"
      @values = {} of String => String
      @leaves = [] of Tree

      @@counter += 1
    end

    def [](index : String)
      return leaves.select { |leaf| leaf.id == index }[0]
    end
  end

  class Lexer
    def self.init_control(control : String) : Tuple(Tree, String)
      match_index = 0

      control_type = /^[A-Za-z]+\s+/.match(control)

      if control_type.nil?
        raise LexError.new("Type of Control could not be found")
      else
        temp = control_type.not_nil![0]
        match_index += temp.size
        control_type = temp.strip
      end

      id = /(?<=#)[a-z_](?=\s*{)/.match(control[match_index..-1])

      if id.nil?
        tree = Tree.new(control_type)
      else
        temp = id.not_nil![0]
        match_index += id.size
        tree = Tree.new(control_type, temp.strip)
      end

      end_index = match_index
      paren_check = 1

      until paren_check.zero?
        end_index += 1
        raise LexError.new("Could not find ending }") if end_index == control.size

        if control[end_index] == '{'
          paren_check += 1
        elsif control[end_index] == '}'
          paren_check -= 1
        end
      end

      content = control[match_index + 1...end_index - 1]
      
      return {tree, content}
    end

    def self.lex_control(control : String) : Tree
      tree, content = self.init_control(control)

      content = content.split(";").map(&.strip)

      return tree
    end

    def self.lex(filename : String) : Tree
      contents = File.read(filename)
      tree = self.lex_control(contents.strip)

      return tree
    end
  end
end
