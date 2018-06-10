require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class Label < Widget
    include Control

    @this : UI::Label*

    def initialize(text : String)
      @this = UI.new_label(text)
    end

    def self.init_markup(args : MLArgs)
      return self.new(args["text"].as(String))
    end

    def text : String
      return UI.label_text(to_unsafe)
    end

    def text=(label_text : String)
      UI.label_set_text(to_unsafe, label_text)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end
end