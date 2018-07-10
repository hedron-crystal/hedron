require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Slider < Widget
    include Control

    @@box : Void*?

    @this : UI::Slider*

    def initialize(bounds : Tuple(Int32, Int32))
      @this = UI.new_slider(bounds[0], bounds[1])
    end

    def initialize(@this); end

    def self.init_markup(args : MLArgs)
      return self.new({args["upper"].as(Int32), args["lower"].as(Int32)})
    end

    def on_change(&block)
      on_change = block
    end

    def on_change=(proc : Proc(Slider, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(slider : UI::Slider*, data : Void*) {
        callback = ::Box(Proc(Slider, Nil)).unbox(data)
        callback.call(Slider.new(slider))
      }

      UI.slider_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def value : Int32
      return UI.slider_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.slider_set_value(to_unsafe, val)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "value" => Int32})
    end

    def to_unsafe
      return @this
    end
  end
end
