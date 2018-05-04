require "../bindings.cr"
require "./control.cr"

module Hedron
  class Combobox < Control
    @this : UI::Combobox*

    def initialize
      @this = UI.new_combobox
    end

    def choices=(choices : Array(String))
      choices.each do |choice|
        UI.combobox_append(to_unsafe, choice)
      end
    end

    def on_select=(proc : Proc(UI::Combobox*, Void*, Void))
      UI.combobox_on_selected(to_unsafe, proc, nil)
    end

    def selected : Int32
      return UI.combobox_selected(to_unsafe)
    end

    def selected=(index : Int32)
      UI.combobox_set_selected(to_unsafe, index)
    end

    def to_unsafe
      @this
    end
  end
end