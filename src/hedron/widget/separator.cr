require "../bindings.cr"
require "./control.cr"

module Hedron
  abstract class Separator < Control; end

  class HorizontalSeparator < Separator
    @this : UI::Separator*

    def initialize
      @this = UI.new_horizontal_separator
    end

    def to_unsafe
      @this
    end
  end

  class VerticalSeparator < Separator
    @this : UI::Separator*

    def initialize
      @this = UI.new_vertical_separator
    end

    def to_unsafe
      @this
    end
  end
end