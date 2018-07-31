require "../ui/*"

require "../render.cr"
require "./lexer.cr"
require "./tree.cr"
require "./type_parser.cr"

module Hedron::HDML
  private class Parser
    private def self.separate_props(values : Hash(String, Any)) : Tuple(Hash(String, Any), Hash(String, Any))
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

    private def self.set_children(render : Render)
      case render.widget
      when SingleContainer
        child = render.children.values[0].widget
        raise ParseError.new("Child #{child} has index when it's not meant to") unless child.index.nil?
        raise ParseError.new("SingleContainer can only have one child") if render.children.size != 1

        render.widget.as(SingleContainer).child = child
      when MultipleContainer
        render.children.each do |_, child|
          widget = child.widget
          raise ParseError.new("Child #{child} has index when it's not meant to") unless widget.index.nil?
          render.widget.as(MultipleContainer).push(widget)
        end
      when IndexedContainer
        render.children.each do |_, child|
          widget = child.widget
          index = widget.index
          raise ParseError.new("Child #{child} does not have index") if index.nil?
          render.widget.as(IndexedContainer)[index] = widget
        end
      end
    end

    def self.parse_tree(tree : Tree) : Render
      init_props, props = separate_props(tree.values)

      widget = if init_props.size.zero?
                 Classes.classes[tree.node_class].init_markup.as(Widget)
               else
                 Classes.classes[tree.node_class].init_markup(init_props).as(Widget)
               end

      widget.id = tree.id
      widget.index = tree.index

      props.each do |key, val|
        widget.set_property(key, val)
      end

      render = Render.new(widget)

      tree.leaves.each do |leaf|
        render.add_child(parse_tree(leaf))
      end

      set_children(render)
      return render
    end

    def self.parse_from_render(class_name : String, id : String?, index : String?, values : MLArgs?, children : Array(Render)?) : Render
      init_props, props = separate_props(values)
      id = TemporaryID.new_id if id.nil?
      values = {} of String => Any if values.nil?
      children = [] of Render if children.nil?

      widget = if init_props.size.zero?
                 Classes.classes[class_name].init_markup.as(Widget)
               else
                 Classes.classes[class_name].init_markup(init_props).as(Widget)
               end

      widget.id = id
      widget.index = index

      props.each do |key, val|
        widget.set_property(key, val)
      end

      render = Render.new(widget)

      indices = [] of String?

      children.each do |child|
        render.add_child(child)
      end

      set_children(render)
      return render
    end
  end
end
