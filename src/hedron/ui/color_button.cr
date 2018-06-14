require "../bindings.cr"
require "../struct/color.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class ColorButton < Widget
    include Control

    @this : UI::ColorButton*

    def initialize
      @this = UI.new_color_button
    end

    def self.init_markup
      return self.new
    end

    def on_change=(proc : Proc(UI::ColorButton*, Void*, Void))
      UI.color_button_on_changed(to_unsafe, proc, nil)
    end

    def color=(color : Color)
      UI.color_button_set_color(to_unsafe, color.red, color.green, color.blue, color.alpha)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool})
    end

    def to_unsafe
      return @this
    end
  end
end