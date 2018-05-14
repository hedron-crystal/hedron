require "./type_parser.cr"

module Hedron
  private class Tree
    @@counter = 0

    property index : String?
    property node_class : String
    property id : String
    property values : Hash(String, String)
    property leaves : Array(Tree)

    def initialize(@node_class, @id)
      @index = nil
      @values = {} of String => String
      @leaves = [] of Tree
    end

    def initialize(@node_class)
      @index = nil
      @id = "##{@@counter}"
      @values = {} of String => String
      @leaves = [] of Tree

      @@counter += 1
    end

    def [](index : String)
      return leaves.select { |leaf| leaf.id == index }[0]
    end
  end

  private class Lexer
    def self.init_controls(control : String) : Array(Tuple(Tree, String))
      parsed_trees = [] of Tuple(Tree, String)

      until control.size.zero?
        control_type = /^[A-Za-z]+\s*/m.match(control)

        if control_type.nil?
          raise LexError.new("Type of Control could not be found")
        else
          temp = control_type.not_nil![0]
          control = control[temp.size..-1]
          control_type = temp.strip
        end

        id = /^#[a-z_]+\s*(?=\{)/m.match(control)

        if id.nil?
          tree = Tree.new(control_type)
        else
          temp = id.not_nil![0]
          control = control[temp.size..-1]
          tree = Tree.new(control_type, temp[1..-1].strip)
        end

        end_index = 0
        paren_check = 1

        until paren_check.zero?
          end_index += 1

          if end_index == control.size
            raise LexError.new("Could not find ending }")
          end

          if control[end_index] == '{'
            paren_check += 1
          elsif control[end_index] == '}'
            paren_check -= 1
          end
        end

        content = control[1...end_index - 1]
        new_index = end_index + /^\s*/i.match(control[end_index + 1..-1]).not_nil![0].size + 1
        control = control[new_index..-1]
        
        parsed_trees.push({tree, content})
      end

      return parsed_trees
    end

    def self.lex_controls(control : String) : Array(Tree)
      init_trees = self.init_controls(control)
      lexed_trees = [] of Tree

      init_trees.each do |t|
        tree, content = t

        content = content.split(";").map(&.strip)
        index = nil
        
        (0...content.size).each do |n|
          if !content[n].includes?("{")
            key, value = content[n].split(":").map(&.strip)

            if key == "^index"
              tree.index = TypeParser.parse(value).as(String)
            else
              tree.values[key] = value
            end
          else
            index = n
            break
          end
        end

        unless index.nil?
          subtrees = content[index..-1].join(";").strip
          tree.leaves = self.lex_controls(subtrees)
        end

        lexed_trees.push(tree)
      end

      return lexed_trees
    end

    def self.lex_toplevel(control : String) : Tree
      trees = self.lex_controls(control)

      raise LexError.new("Could not find top-level widget") if trees.size.zero?
      raise LexError.new("Only 1 widget allowed in top-level") if trees.size > 1
      return trees[0]
    end

    def self.lex(filename : String) : Tree
      contents = File.read(filename)
      tree = self.lex_toplevel(contents.strip)

      return tree
    end
  end
end
