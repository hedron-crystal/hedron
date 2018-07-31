require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class ProgressBar < Control
    gen_properties({"stretchy" => Bool, "value" => Int32})

    def initialize
      @this = ui_control(UI.new_progress_bar)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def value : Int32
      return UI.progress_bar_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.progress_bar_set_value(to_unsafe, val)
    end

    def to_unsafe
      return @this.as(UI::ProgressBar*)
    end
  end
end
