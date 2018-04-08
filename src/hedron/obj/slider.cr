require "../bindings.cr"
require "./control.cr"

module Hedron
  class Slider < Control
    @bounds : Tuple(Int32, Int32)
    @this : UI::Slider*

    def initialize(@bounds)
      @this = UI.new_slider(@bounds[0], @bounds[1])
    end

    def on_change=(proc : Proc(UI::Slider*, Void*, Void))
      UI.slider_on_changed(to_unsafe, proc, nil)
    end

    def value : Int32
      return UI.slider_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.slider_set_value(to_unsafe, val)
    end

    def to_unsafe
      @this
    end
  end
end