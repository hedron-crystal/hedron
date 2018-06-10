require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  abstract class Box < MultipleContainer
    include Control
    
    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def add(child : Widget)
      child.parent = self
      control = child.display

      if control.is_a?(Control)
        UI.box_append(to_unsafe, ui_control(control.to_unsafe), to_int(control.stretchy?))
      end
    end

    def add_all(*children : Widget)
      children.each { |child| add(child) }
    end

    def delete(index : Int32)
      UI.box_delete(to_unsafe, index)
    end

    def padded : Bool
      return to_bool(UI.box_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      UI.box_set_padded(to_unsafe, to_int(is_padded))
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "padded" => Bool})
    end
  end

  class VerticalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_vertical_box
    end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this
    end
  end

  class HorizontalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_horizontal_box
    end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this
    end
  end
end