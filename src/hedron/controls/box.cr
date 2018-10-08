require "./control"
require "../containers/container"

module Hedron
  private class Box < Control
    include Container

    private def ptr
      return self.to_unsafe.as(UI::Box*)
    end

    def self.cast_ptr(ptr)
      return ptr.as(UI::Box*)
    end

    def delete_at(index : Int32)
      @children.delete_at(index)
      UI.box_delete(ptr, index)
    end

    def padded? : Bool
      return Control.to_bool(UI.box_padded(ptr))
    end

    def padded=(value : Bool)
      return UI.box_set_padded(ptr, Control.to_int(value))
    end

    def push(control : Control, stretchy : Bool = true)
      @children.push(control)
      UI.box_append(ptr, control, stretchy)
    end
  end

  class HorizontalBox < Box
    def initialize
      @this = Control.cast_ptr(UI.new_horizontal_box)
    end
  end

  class VerticalBox < Box
    def initialize
      @this = Control.cast_ptr(UI.new_vertical_box)
    end
  end
end
