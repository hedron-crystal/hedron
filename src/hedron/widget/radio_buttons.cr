require "../bindings.cr"
require "./control.cr"

module Hedron
  class RadioButtons < Control
    @this : UI::RadioButtons*

    def initialize
      @this = UI.new_radio_buttons
    end

    def choices=(choices : Array(String))
      choices.each do |choice|
        UI.radio_buttons_append(to_unsafe, choice)
      end
    end

    def on_select=(proc : Proc(UI::RadioButtons*, Void*, Void))
      UI.radio_buttons_on_selected(to_unsafe, proc, nil)
    end

    def selected : Int32
      return UI.radio_buttons_selected(to_unsafe)
    end

    def selected=(index : Int32)
      UI.radio_buttons_set_selected(to_unsafe, index)
    end

    def to_unsafe
      @this
    end
  end
end