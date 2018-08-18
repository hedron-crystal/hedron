require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Button < Control
    gen_properties({"stretchy" => Bool, "text" => String})

    @@box : Void*?

    def initialize(text : String)
      @this = ui_control(UI.new_button(text))
    end

    def initialize(@this); end

    def self.init_markup(args : MLArgs)
      return self.new(args["text"].as(String))
    end

    def on_click(&block : Button ->)
      self.on_click = block
    end

    def on_click=(proc : Proc(Button, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(button : UI::Button*, data : Void*) {
        callback = ::Box(Proc(Button, Nil)).unbox(data)
        callback.call(Button.new(ui_control(button)))
      }

      UI.button_on_clicked(to_unsafe, new_proc, boxed_data)
    end

    def text : String
      return String.new(UI.button_text(to_unsafe))
    end

    def text=(button_text : String)
      UI.button_set_text(to_unsafe, button_text)
    end

    def to_unsafe
      return @this.as(UI::Button*)
    end
  end
end
