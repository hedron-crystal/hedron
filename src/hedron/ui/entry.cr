require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Entry < Widget
    include Control

    @@box : Void*?

    @this : UI::Entry*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize
      @this = UI.new_entry
    end

    def self.init_markup
      return self.new
    end

    def on_change(&block : Button ->)
      self.on_change = block
    end

    def on_change=(proc : Proc(Entry, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@entry = self

      new_proc = ->(entry : UI::Entry*, data : Void*) {
        callback = ::Box(Proc(Entry, Nil)).unbox(data)
        callback.call(@@entry.not_nil!)
      }

      UI.entry_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def read_only? : Bool
      return to_bool(UI.entry_read_only(to_unsafe))
    end

    def read_only=(entry_read_only : Bool)
      UI.entry_set_read_only(to_unsafe, to_int(entry_read_only))
    end

    def text : String
      return UI.entry_text(to_unsafe)
    end

    def text=(entry_text : String)
      UI.entry_set_text(to_unsafe, entry_text)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "read_only" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end

  class PasswordEntry < Entry
    def initialize
      @this = UI.new_password_entry
    end
  end

  class SearchEntry < Entry
    def initialize
      @this = UI.new_search_entry
    end
  end
end