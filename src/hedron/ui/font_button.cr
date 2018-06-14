require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class FontButton < Widget
    include Control

    @@box : Void*?

    @this : UI::FontButton*

    def initialize
      @this = UI.new_font_button
    end

    def self.init_markup
      return self.new
    end

    def font : UI::FontDescriptor
      UI.font_button_font(to_unsafe, out button_font)
      return button_font
    end

    def on_change=(&block : FontButton ->)
      self.on_change = block
    end

    def on_change=(proc : Proc(FontButton, Void))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@font_button = self

      new_proc = ->(font_button : UI::FontButton*, data : Void*) {
        callback = ::Box(Proc(FontButton, Nil)).unbox(data)
        callback.call(@@font_button.not_nil!)
      }

      UI.font_button_on_changed(to_unsafe, new_proc, boxed_data)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool})
    end

    def to_unsafe
      return @this
    end
  end
end