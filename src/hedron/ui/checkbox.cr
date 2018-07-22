require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Checkbox < Widget
    include Control

    @this : UI::Checkbox*

    def initialize(text : String)
      @this = UI.new_checkbox(text)
    end

    def self.init_markup(args : MLArgs)
      return self.new(args["text"].as(String))
    end

    def checked? : Bool
      return to_bool(UI.checkbox_checked(to_unsafe))
    end

    def checked=(is_checked : Bool)
      return UI.checkbox_set_checked(to_unsafe, to_int(is_checked))
    end

    def text : String
      return UI.checkbox_text
    end

    def text=(checkbox_text : String)
      UI.checkbox_set_text(to_unsafe, checkbox_text)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "checked" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end
end
