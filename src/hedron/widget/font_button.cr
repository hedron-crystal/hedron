require "../bindings.cr"
require "./control.cr"

module Hedron
  class FontButton < Control
    @this : UI::FontButton*

    def initialize
      @this = UI.new_font_button
    end

    def font : UI::FontDescriptor
      UI.font_button_font(to_unsafe, out button_font)
      return button_font
    end

    def on_change=(proc : Proc(UI::FontButton*, Void*, Void))
      UI.font_button_on_changed(to_unsafe, proc, nil)
    end

    def to_unsafe
      @this
    end
  end
end