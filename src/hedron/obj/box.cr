require "../bindings.cr"
require "./control.cr"

module Hedron
  abstract class Box < Control
    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def add(control : Control, stretchy : Bool = false)
      control.parent = self
      UI.box_append(to_unsafe, ui_control(control.to_unsafe), to_int(stretchy))
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
  end

  class VerticalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_vertical_box
    end

    def to_unsafe
      @this
    end
  end

  class HorizontalBox < Box
    @this : UI::Box*

    def initialize
      @this = UI.new_horizontal_box
    end

    def to_unsafe
      @this
    end
  end
end