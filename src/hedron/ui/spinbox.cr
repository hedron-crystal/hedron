require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Spinbox < Control
    @@box : Void*?

    gen_properties({"stretchy" => Bool, "value" => Int32})

    def initialize(bounds : Tuple(Int32, Int32))
      @this = ui_control(UI.new_spinbox(bounds[0], bounds[1]))
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
        callback.call(Spinbox.new(ui_control(spinbox)))
      }

      UI.spinbox_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def value : Int32
      return UI.spinbox_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.spinbox_set_value(to_unsafe, val)
    end

    def to_unsafe
      @this.as(UI::Spinbox*)
    end
  end
end
