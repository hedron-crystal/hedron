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
  
  class Parser
    @classes : Hash(String, Widget.class)

    def initialize
      @classes = CLASS_LIST.map do |el|
        {el.widget_name, el}
      end.to_h
    end

    def add_class(class_name : Widget.class)
      @classes[class_name.widget_name] = class_name
    end

    private def parse_from_lex(tree : Tree) : NestedParsed
      init_types = {} of String => Any
      types = {} of String => Any

      tree.values.each do |key, val|
        if key.starts_with?("@")
          init_types[key[1..-1]] = TypeParser.parse(val)
        else
          types[key] = TypeParser.parse(val)
        end
      end

      nested = if init_types.size.zero?
        NestedParsed.new(tree.id, @classes[tree.node_class].init_markup)
      else
        NestedParsed.new(tree.id, @classes[tree.node_class].init_markup(init_types))
      end

      types.each do |key, val|
        nested.widget.set_attribute(key, val)
      end

      indices = [] of String?

      tree.leaves.each do |leaf|
        nested.children.push(parse_from_lex(leaf))
        indices.push(leaf.index)
      end

      case nested.widget
        when SingleContainer
          raise ParseError.new("SingleContainer can only have one child") if nested.children.size != 1
          nested.widget.as(SingleContainer).child = nested.children[0].widget
        when MultipleContainer
          nested.children.each do |child|
            nested.widget.as(MultipleContainer).add(child.widget)
          end
        when IndexedContainer
          if indices.any?(&.nil?)
            raise ParseError.new("All children of IndexedContainer must have ^index property")
          end

          indices = indices.map(&.not_nil!)

          (0...indices.size).each do |n|
            child = nested.children[n].widget
            index = indices[n]

            nested.widget.as(IndexedContainer)[index] = child
          end
      end

      return nested
    end

    def flatten(nested : NestedParsed) : Parsed
      widgets = Parsed.new
      widgets.items[nested.id] = nested.widget

      nested.children.each do |child|
        widgets.items.merge!(flatten(child).items)
      end

      return widgets
    end

    def parse(filename : String) : Parsed
      nested = parse_from_lex(Lexer.lex(filename))
      return flatten(nested)
    end
  end
end
