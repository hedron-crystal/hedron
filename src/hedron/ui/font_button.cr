require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class FontButton < Control
    @@box : Void*?

    gen_properties({"stretchy" => Bool})

    def initialize
      @this = ui_control(UI.new_font_button)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def font : UI::FontDescriptor
      UI.font_button_font(to_unsafe, out button_font)
      return button_font
    end

    def on_change(&block : FontButton ->)
      self.on_change = block
    end

    def on_change=(proc : Proc(FontButton, Void))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(font_button : UI::FontButton*, data : Void*) {
        callback = ::Box(Proc(FontButton, Nil)).unbox(data)
        callback.call(FontButton.new(ui_control(font_button)))
      }

      UI.font_button_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def to_unsafe
      return @this.as(UI::FontButton*)
    end
  end
end
