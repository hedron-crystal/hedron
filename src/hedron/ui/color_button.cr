require "../bindings.cr"
require "../struct/color.cr"
require "../widget/control.cr"

module Hedron
  class ColorButton < Control
    gen_properties({"stretchy" => Bool})

    def initialize
      @this = ui_control(UI.new_color_button)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def on_change=(proc : Proc(UI::ColorButton*, Void*, Void))
      UI.color_button_on_changed(to_unsafe, proc, nil)
    end

    def color=(color : Color)
      UI.color_button_set_color(to_unsafe, color.red, color.green, color.blue, color.alpha)
    end

    def to_unsafe
      return @this.as(UI::ColorButton*)
    end
  end
end
