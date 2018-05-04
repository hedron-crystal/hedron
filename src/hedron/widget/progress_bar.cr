require "../bindings.cr"
require "./control.cr"

module Hedron
  class ProgressBar < Control
    @this : UI::ProgressBar*

    def initialize
      @this = UI.new_progress_bar
    end

    def value : Int32
      return UI.progress_bar_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.progress_bar_set_value(to_unsafe, val)
    end

    def to_unsafe
      @this
    end
  end
end