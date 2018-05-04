require "../bindings.cr"
require "./control.cr"

module Hedron
  class Slider < Control
    @@box : Void*?

    @bounds : Tuple(Int32, Int32)
    @this : UI::Slider*

    def initialize(@bounds)
      @this = UI.new_slider(@bounds[0], @bounds[1])
    end

    def on_change(&block)
      on_change = block
    end

    def on_change=(proc : Proc(Slider, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@slider = self

      new_proc = ->(slider : UI::Slider*, data : Void*) {
        callback = ::Box(Proc(Slider, Nil)).unbox(data)
        callback.call(@@slider.not_nil!)
      }

      UI.slider_on_changed(to_unsafe, new_proc, boxed_data)
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