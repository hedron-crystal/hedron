require "../bindings.cr"
require "./control/*"

module Hedron
  class ProgressBar < Widget
    include ControlMethods

    @this : UI::ProgressBar*

    def initialize
      @this = UI.new_progress_bar
    end

    def self.init_markup
      return self.new
    end

    def value : Int32
      return UI.progress_bar_value(to_unsafe)
    end

    def value=(val : Int32)
      UI.progress_bar_set_value(to_unsafe, val)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "value" => Int32})
    end

    def to_unsafe
      return @this
    end
  end
end