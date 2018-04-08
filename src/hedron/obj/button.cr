require "../bindings.cr"
require "./control.cr"

module Hedron
  class Button < Control
    @name : String
    @this : UI::Button*

    def initialize(@name)
      @this = UI.new_button(@name)
    end

    def on_click=(proc : Proc(UI::Button*, Void*, Void))
      UI.button_on_clicked(to_unsafe, proc, nil)
    end

    def text : String
      return UI.button_text(to_unsafe)
    end

    def text=(button_text : String)
      UI.button_set_text(to_unsafe, button_text)
    end

    def to_unsafe
      @this
    end
  end
end