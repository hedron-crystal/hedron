require "../bindings.cr"
require "./control.cr"

module Hedron
  class Checkbox < Control
    @this : UI::Checkbox*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize
      @this = UI.new_checkbox("")
    end

    def initialize(text : String)
      @this = UI.new_checkbox(text)
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
      @this
    end
  end
end