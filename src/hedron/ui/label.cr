require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Label < Control
    gen_properties({"stretchy" => Bool, "text" => String})

    def initialize(text : String)
      @this = ui_control(UI.new_label(text))
    end

    def initialize(@this); end

    def self.init_markup(args : MLArgs)
      return self.new(args["text"].as(String))
    end

    def text : String
      return String.new(UI.label_text(to_unsafe))
    end

    def text=(label_text : String)
      UI.label_set_text(to_unsafe, label_text)
    end

    def to_unsafe
      return @this.as(UI::Label*)
    end
  end
end
