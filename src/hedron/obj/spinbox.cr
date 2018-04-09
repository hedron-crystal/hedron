require "../bindings.cr"
require "./control.cr"

module Hedron
  class Spinbox < Control
    @@box : Void*?
    @bounds : Tuple(Int32, Int32)
    @this : UI::Spinbox*

    def initialize(@bounds)
      @this = UI.new_spinbox(@bounds[0], @bounds[1])
    end

    def on_change(&block)
      on_change = block
    end

    def on_change=(proc : Proc(Spinbox, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@spinbox = self

      new_proc = ->(spinbox : UI::Spinbox*, data : Void*) {
        callback = ::Box(Proc(Spinbox, Nil)).unbox(data)
        callback.call(@@spinbox.not_nil!)
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
      @this
    end
  end
end