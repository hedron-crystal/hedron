require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Entry < Control
    @@box : Void*?

    gen_properties({"stretchy" => Bool, "read_only" => Bool, "text" => String})

    def initialize
      @this = ui_control(UI.new_entry)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def on_change(&block : Button ->)
      self.on_change = block
    end

    def on_change=(proc : Proc(Entry, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(entry : UI::Entry*, data : Void*) {
        callback = ::Box(Proc(Entry, Nil)).unbox(data)
        callback.call(Entry.new(ui_control(entry)))
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
      return String.new(UI.entry_text(to_unsafe))
    end

    def text=(entry_text : String)
      UI.entry_set_text(to_unsafe, entry_text)
    end

    def to_unsafe
      return @this.as(UI::Entry*)
    end
  end

  class PasswordEntry < Entry
    def initialize
      @this = ui_control(UI.new_password_entry)
    end
  end

  class SearchEntry < Entry
    def initialize
      @this = ui_control(UI.new_search_entry)
    end
  end
end
