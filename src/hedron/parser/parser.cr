require "../ui/*"
require "../widget/*"
require "./lexer.cr"
require "./parse_classes.cr"
require "./tree.cr"
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

    private def separate_props(values : Hash(String, Any)) : Tuple(Hash(String, Any), Hash(String, Any))
      init_props = {} of String => Any
      props = {} of String => Any

      values.each do |key, val|
        if key.starts_with?("@")
          init_props[key[1..-1]] = val
        else
          props[key] = val
        end
      end

      return {init_props, props}
    end

    def parse_tree(tree : Tree) : Parsed
      init_props, props = separate_props(tree.values)

      parsed = if init_props.size.zero?
        Parsed.new(tree.id, @classes[tree.node_class].init_markup)
      else
        Parsed.new(tree.id, @classes[tree.node_class].init_markup(init_props))
      end

      props.each do |key, val|
        parsed.widget.set_attribute(key, val)
      end

      parsed.widget.id = tree.id
      parsed.widget.index = tree.index

      indices = [] of String?

      tree.leaves.each do |leaf|
        parsed.add_child(parse_tree(leaf))
        indices.push(leaf.index)
      end

      case parsed.widget
        when SingleContainer
          child = parsed.children[0].widget
          raise ParseError.new("Child #{child} has index when it's not meant to") unless indices[0].nil?
          raise ParseError.new("SingleContainer can only have one child") if parsed.children.size != 1

          parsed.widget.as(SingleContainer).child = parsed.children[0].widget
        when MultipleContainer
          (0...parsed.children.size).each do |n|
            child = parsed.children[n].widget
            raise ParseError.new("Child #{child} has index when it's not meant to") unless indices[n].nil?

            parsed.widget.as(MultipleContainer).add(child)
          end
        when IndexedContainer
          (0...parsed.children.size).each do |n|
            child = parsed.children[n].widget
            index = indices[n]
            raise ParseError.new("Child #{child} does not have index") if index.nil?

            parsed.widget.as(IndexedContainer)[index] = child
          end
      end

      return parsed
    end

    def to_tree(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Tree)?) : Tree
      tree = id.nil? ? Tree.new(class_name) : Tree.new(class_name, id)

      values = {} of String => Any if values.nil?
      new_values = {} of String => Any
      values.each { |k, v| new_values[k] = v.as(Any) }
      values = new_values
      
      children = [] of Tree if children.nil?

      tree.values = values
      tree.index = index
      tree.leaves = children

      return tree
    end

    def parse_from_render(tree : Tree) : Parsed
      return parse_tree(tree)
    end
  end
end
