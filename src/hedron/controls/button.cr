require "./control"
require "../native/macros"

module Hedron
  class Button < Control
    private def ptr
      return @this.as(UI::Button*)
    end

    protected def initialize(@this); end

    def initialize(text : String)
      @this = Control.cast_ptr(UI.new_button(text))
    end

    Hedron.listener on_clicked, Button

    def text : String
      return Control.to_str(UI.button_text(ptr))
    end

    def text=(value : String)
      UI.button_set_text(ptr, value)
    end
  end
end