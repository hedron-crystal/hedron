require "../bindings.cr"
require "../color.cr"
require "./control.cr"

module Hedron
  class ColorButton < Control
    @this : UI::ColorButton*

    def initialize
      @this = UI.new_color_button
    end

    def on_change=(proc : Proc(UI::ColorButton*, Void*, Void))
      UI.color_button_on_changed(to_unsafe, proc, nil)
    end

    def color=(color : Color)
      UI.color_button_set_color(to_unsafe, color.red, color.green, color.blue, color.alpha)
    end

    def to_unsafe
      @this
    end
  end
end