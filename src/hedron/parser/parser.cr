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

    private def set_children(parsed : Parsed)
      case parsed.widget
        when SingleContainer
          child = parsed.children[0].widget
          raise ParseError.new("Child #{child} has index when it's not meant to") unless child.index.nil?
          raise ParseError.new("SingleContainer can only have one child") if parsed.children.size != 1

          parsed.widget.as(SingleContainer).child = child
        when MultipleContainer
          parsed.children.each do |child|
            widget = child.widget
            raise ParseError.new("Child #{child} has index when it's not meant to") unless widget.index.nil?
            parsed.widget.as(MultipleContainer).add(widget)
          end
        when IndexedContainer
          parsed.children.each do |child|
            widget = child.widget
            index = widget.index
            raise ParseError.new("Child #{child} does not have index") if index.nil?
            parsed.widget.as(IndexedContainer)[index] = widget
          end
      end
    end

    def parse_tree(tree : Tree) : Parsed
      init_props, props = separate_props(tree.values)

      parsed = if init_props.size.zero?
        Parsed.new(tree.id, @classes[tree.node_class].init_markup)
      else
        Parsed.new(tree.id, @classes[tree.node_class].init_markup(init_props))
      end

      props.each do |key, val|
        parsed.widget.set_property(key, val)
      end

      parsed.widget.id = tree.id
      parsed.widget.index = tree.index

      tree.leaves.each do |leaf|
        parsed.add_child(parse_tree(leaf))
      end

      set_children(parsed)
      return parsed
    end

    def parse_from_render(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Parsed)?) : Parsed
      init_props, props = separate_props(values)
      id = TemporaryID.new_id if id.nil?
      values = {} of String => Any if values.nil?
      children = [] of Parsed if children.nil?

      parsed = if init_props.size.zero?
        Parsed.new(id, @classes[class_name].init_markup)
      else
        Parsed.new(id, @classes[class_name].init_markup(init_props))
      end

      props.each do |key, val|
        parsed.widget.set_property(key, val)
      end

      parsed.widget.id = id
      parsed.widget.index = index

      indices = [] of String?

      children.each do |child|
        parsed.add_child(child)
      end

      set_children(parsed)
      return parsed
    end
  end
end
