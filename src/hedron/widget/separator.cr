require "../bindings.cr"
require "./control/*"

module Hedron
  abstract class Separator < Widget
    include ControlMethods
  end

  class HorizontalSeparator < Separator
    @this : UI::Separator*

    def initialize
      @this = UI.new_horizontal_separator
    end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this
    end
  end

  class VerticalSeparator < Separator
    @this : UI::Separator*

    def initialize
      @this = UI.new_vertical_separator
    end

    def to_unsafe
      return @this
    end
  end
end