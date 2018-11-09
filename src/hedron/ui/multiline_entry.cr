require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class MultilineEntry < Control
    gen_properties({
      "stretchy" => Bool, "read_only" => Bool, "text" => String,
    })

    def initialize
      @this = ui_control(UI.new_multiline_entry)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def on_click(&block : MultilineEntry ->)
      self.on_click = block
    end

    def on_click=(proc : Proc(MultilineEntry, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(ml_entry : UI::MultilineEntry*, data : Void*) {
        callback = ::Box(Proc(MultilineEntry, Nil)).unbox(data)
        callback.call(MultilineEntry.new(ui_control(ml_entry)))
      }

      UI.multiline_entry_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def push(entry_text : String)
      UI.multiline_entry_append(to_unsafe, entry_text)
    end

    def read_only? : Bool
      return to_bool(UI.multiline_entry_read_only(to_unsafe))
    end

    def read_only=(is_read_only : Bool)
      UI.multiline_entry_set_read_only(to_unsafe, to_int(is_read_only))
    end

    def text : String
      return String.new(UI.multiline_entry_text(to_unsafe))
    end

    def text=(entry_text : String)
      UI.multiline_entry_set_text(to_unsafe, entry_text)
    end

    def to_unsafe
      return @this.as(UI::MultilineEntry*)
    end
  end

  class NonWrappingMultilineEntry < MultilineEntry
    def initialize
      @this = ui_control(UI.new_non_wrapping_multiline_entry)
    end
  end
end
