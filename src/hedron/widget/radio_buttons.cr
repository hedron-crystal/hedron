require "../bindings.cr"
require "./control/*"

module Hedron
  class RadioButtons < Widget
    include ControlMethods

    @@box : Void*?

    @this : UI::RadioButtons*

    def initialize
      @this = UI.new_radio_buttons
    end

    def self.init_markup
      return self.new
    end

    def choices=(choices : Array(String))
      choices.each do |choice|
        UI.radio_buttons_append(to_unsafe, choice)
      end
    end

    def on_select(&block : RadioButtons ->)
      self.on_select = block
    end

    def on_select=(proc : Proc(RadioButtons, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@rbuttons = self

      new_proc = ->(rbuttons : RadioButtons, data : Void*) {
        callback = ::Box(Proc(Button, Nil)).unbox(data)
        callback.call(@@rbuttons.not_nil!)
      }

      UI.radio_buttons_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def selected : Int32
      return UI.radio_buttons_selected(to_unsafe)
    end

    def selected=(index : Int32)
      UI.radio_buttons_set_selected(to_unsafe, index)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "selected" => Int32})
    end

    def to_unsafe
      return @this
    end
  end
end