require "../ui/**"
require "./lexer.cr"
require "./type_parser.cr"

module Hedron
  alias Parsed = Hash(String, Widget)
  
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

    private def parse_from_lex(tree : Tree) : Parsed
      controls = {} of String => Widget
      init_types = {} of String => Any
      types = {} of String => Any

      tree.values.each do |key, val|
        if key.starts_with?("@")
          init_types[key[1..-1]] = TypeParser.parse(val)
        else
          types[key] = TypeParser.parse(val)
        end
      end

      controls[tree.id] = if init_types.size.zero?
        @classes[tree.node_class].init_markup
      else
        @classes[tree.node_class].init_markup(init_types)
      end

      types.each do |key, val|
        controls[tree.id].set_attribute(key, val)
      end

      results = {} of String => Widget
      
      tree.leaves.each do |leaf|
        results.merge!(parse_from_lex(leaf))
      end

      case controls[tree.id]
        when SingleContainer
          if results.select { |key, val| val.parent.nil? }.size != 1
            raise ParseError.new("SingleContainer class does not have 1 child")
          end

          controls[tree.id].as(SingleContainer).child = results[results.keys[0]]
        when MultipleContainer
          results.each do |key, val|
            controls[tree.id].as(MultipleContainer).add(val)
          end
      end

      controls.merge!(results)

      return controls
    end

    def parse(filename : String) : Parsed
      return parse_from_lex(Lexer.lex(filename))
    end
  end
end
