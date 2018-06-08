require "../ui/*"
require "../widget/*"
require "./lexer.cr"
require "./parse_classes.cr"
require "./type_parser.cr"

module Hedron
  CLASS_LIST = [
    Button, Checkbox, ColorButton, Combobox, DatePicker, DateTimePicker,
    EditableCombobox, Entry, FontButton, Group, HorizontalBox, HorizontalSeparator,
    Label, MultilineEntry, NonWrappingMultilineEntry, PasswordEntry, ProgressBar,
    RadioButtons, SearchEntry, Separator, Slider, Spinbox, Tab, VerticalBox,
    VerticalSeparator, Window
  ]
  
  private class Parser
    @classes : Hash(String, Widget.class)

    def initialize
      @classes = CLASS_LIST.map do |el|
        {el.widget_name, el}
      end.to_h
    end

    def add_class(wclass : Widget.class)
      @classes[wclass.widget_name] = wclass
    end

    private def parse_from_lex(tree : Tree) : Parsed
      init_types = {} of String => Any
      types = {} of String => Any

      tree.values.each do |key, val|
        if key.starts_with?("@")
          init_types[key[1..-1]] = TypeParser.parse(val)
        else
          types[key] = TypeParser.parse(val)
        end
      end

      parsed = if init_types.size.zero?
        Parsed.new(tree.id, @classes[tree.node_class].init_markup)
      else
        Parsed.new(tree.id, @classes[tree.node_class].init_markup(init_types))
      end

      types.each do |key, val|
        parsed.widget.set_attribute(key, val)
      end

      indices = [] of String?

      tree.leaves.each do |leaf|
        parsed.add_child(parse_from_lex(leaf))
        indices.push(leaf.index)
      end

      case parsed.widget
        when SingleContainer
          raise ParseError.new("SingleContainer can only have one child") if parsed.children.size != 1
          parsed.widget.as(SingleContainer).child = parsed.children[0].widget
        when MultipleContainer
          parsed.children.each do |child|
            parsed.widget.as(MultipleContainer).add(child.widget)
          end
        when IndexedContainer
          (0...indices.size).each do |n|
            child = parsed.children[n].widget
            index = indices[n]
            raise ParseError.new("Child #{child} does not have index") if index.nil?

            parsed.widget.as(IndexedContainer)[index] = child
          end
      end

      return parsed
    end

    def parse(filename : String) : Render
      parsed = parse_from_lex(Lexer.lex(filename))
      return Render.new(parsed)
    end
  end
end
