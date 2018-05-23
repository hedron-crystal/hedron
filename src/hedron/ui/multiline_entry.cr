require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class MultilineEntry < Widget
    include ControlMethods

    @this : UI::MultilineEntry*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize
      @this = UI.new_multiline_entry
    end

    def self.init_markup
      return self.new
    end

    def add(entry_text : String)
      UI.multiline_entry_append(to_unsafe, entry_text)
    end

    def on_click(&block : MultilineEntry ->)
      self.on_click = block
    end

    def on_click=(proc : Proc(MultilineEntry, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@ml_entry = self

      new_proc = ->(ml_entry : UI::MultilineEntry*, data : Void*) {
        callback = ::Box(Proc(MultilineEntry, Nil)).unbox(data)
        callback.call(@@ml_entry.not_nil!)
      }

      UI.multiline_entry_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def read_only? : Bool
      return to_bool(UI.multiline_entry_read_only(to_unsafe))
    end

    def read_only=(is_read_only : Bool)
      UI.multiline_entry_set_read_only(to_unsafe, to_int(is_read_only))
    end

    def text : String
      return UI.multiline_entry_text(to_unsafe)
    end

    def text=(entry_text : String)
      UI.multiline_entry_set_text(to_unsafe, entry_text)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "read_only" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end

  class NonWrappingMultilineEntry < MultilineEntry
    def initialize
      @this = UI.new_non_wrapping_multiline_entry
    end

    def to_unsafe
      return @this
    end
  end
end