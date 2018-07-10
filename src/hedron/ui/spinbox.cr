require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Spinbox < Widget
    include Control

    @@box : Void*?

    @this : UI::Spinbox*

    def initialize(bounds : Tuple(Int32, Int32))
      @this = UI.new_spinbox(bounds[0], bounds[1])
    end

    def initialize(@this); end

    def self.init_markup(args : MLArgs)
      return self.new({args["upper"].as(Int32), args["lower"].as(Int32)})
    end

    def on_change(&block)
      on_change = block
    end

    def on_change=(proc : Proc(Spinbox, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(spinbox : UI::Spinbox*, data : Void*) {
        callback = ::Box(Proc(Spinbox, Nil)).unbox(data)
        callback.call(Spinbox.new(spinbox))
      }

      UI.spinbox_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def value : Int32
      return UI.spinbox_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.spinbox_set_value(to_unsafe, val)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "value" => Int32})
    end

    def to_unsafe
      @this
    end
  end
end
