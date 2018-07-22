require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Form < Widget
    include Control

    @this : UI::Form*

    def initialize
      @this = UI.new_form()
    end

    def delete_at(index : Int32)
      UI.form_delete(to_unsafe, index)
    end

    def padded : Bool
      return to_bool(UI.form_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      UI.form_set_padded(to_unsafe, to_int(is_padded))
    end

    def push(label : Label, widget : Widget)
      UI.form_append(to_unsafe, label.to_unsafe, ui_control(widget.control.to_unsafe), to_int(widget.control.stretchy?))
    end

    def to_unsafe
      return @this
    end
  end
end