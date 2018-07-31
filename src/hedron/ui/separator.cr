require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class HorizontalSeparator < Control
    def initialize
      @this = ui_control(UI.new_horizontal_separator)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this.as(UI::Separator*)
    end
  end

  class VerticalSeparator < Control
    def initialize
      @this = UI.new_vertical_separator
    end

    def initialize(@this); end

    def to_unsafe
      return @this.as(UI::Separator*)
    end
  end
end
