require "../bindings.cr"
require "./control.cr"

module Hedron
  class Label < Control
    @name : String
    @this : UI::Label*

    def initialize(@name)
      @this = UI.new_label(@name)
    end

    def text : String
      return UI.label_text(to_unsafe)
    end

    def text=(label_text : String)
      UI.label_set_text(to_unsafe, label_text)
    end

    def to_unsafe
      @this
    end
  end
end