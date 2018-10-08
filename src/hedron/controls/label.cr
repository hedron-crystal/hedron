require "./control"

module Hedron
  class Label < Control
    private def ptr
      @this.as(UI::Label*)
    end

    def initialize(text : String)
      @this = Control.cast_ptr(UI.new_label(text))
    end

    def text : String
      return Control.to_str(UI.label_text(self.ptr))
    end

    def text=(value : String)
      UI.label_set_text(self.ptr, value)
    end
  end
end