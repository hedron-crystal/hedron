require "./control.cr"

module Hedron
  class MultilineEntry
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

    def add(entry_text : String)
      UI.multiline_entry_append(to_unsafe, entry_text)
    end

    def on_change=(proc : Proc(UI::MultilineEntry*, Void*, Void))
      UI.multiline_entry_on_changed(to_unsafe, proc, nil)
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

    def to_unsafe
      @this
    end
  end
end