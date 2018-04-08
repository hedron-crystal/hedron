require "../bindings.cr"
require "./control.cr"

module Hedron
  class Spinbox < Control
    @bounds : Tuple(Int32, Int32)

    @this : UI::Spinbox*

    def initialize(@bounds)
      @this = UI.new_spinbox(@bounds[0], @bounds[1])
    end

    def on_change=(proc : Proc(UI::Spinbox*, Void*, Void))
      UI.spinbox_on_changed(to_unsafe, proc, nil)
    end

    def value : Int32
      return UI.spinbox_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.spinbox_set_value(to_unsafe, val)
    end

    def to_unsafe
      @this
    end
  end
end