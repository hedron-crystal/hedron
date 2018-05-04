require "../bindings.cr"
require "./control.cr"

module Hedron
  class Entry < Control
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

    def to_unsafe
      @this
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