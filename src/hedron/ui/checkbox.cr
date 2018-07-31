require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Checkbox < Control
    gen_properties({"stretchy" => Bool, "checked" => Bool, "text" => String})

    def initialize(text : String)
      @this = ui_control(UI.new_checkbox(text))
    end

    def initialize(@this); end

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

    def to_unsafe
      return @this.as(UI::Checkbox*)
    end
  end
end
