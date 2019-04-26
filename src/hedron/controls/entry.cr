require "./control"
require "../native/macros"

module Hedron
    class Entry < Control

        private def ptr
            return @this.as(UI::Entry*)
        end
    
        protected def initialize(@this); end

        def initialize
            @this = Control.cast_ptr(UI.new_entry)
        end
    
        Hedron.listener on_changed, Entry
    
        def text : String
            return Control.to_str(UI.entry_text(ptr))
        end
    
        def text=(value : String)
            UI.entry_set_text(ptr, value)
        end

        def read_only? : Bool
            return Control.to_bool(UI.entry_read_only(to_unsafe))
        end
    
        def read_only=(entry_read_only : Bool)
            UI.entry_set_read_only(ptr, Control.to_int(entry_read_only))
        end

    end

    class PasswordEntry < Entry
        def initialize
            @this = Control.cast_ptr(UI.new_password_entry)
        end
    end

    class SearchEntry < Entry
        def initialize
            @this = Control.cast_ptr(UI.new_search_entry)
        end
    end
end