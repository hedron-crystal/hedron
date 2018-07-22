require "../binding.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Grid
    include Control

    @this : UI::Grid*

    def initialize
      @this = UI.new_grid
    end

    def insert(widget : Widget, next_to : Widget, side : Side, xspan : Int32, yspan : Int32, hexpand : Int32, halign : Align, yexpand : Int32, yalign : Align)
      UI.grid_insert_at(to_unsafe, ui_control(widget.control.to_unsafe), ui_control(next_to.control.to_unsafe), side, xspan, yspan, hexpand, halign, yexpand, yalign)
    end

    def padded : Bool
      return to_bool(UI.grid_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      return UI.grid_set_padded(to_unsafe, to_int(is_padded))
    end

    def push(widget : Widget, left : Int32, top : Int32, xspan : Int32, yspan : Int32, hexpand : Int32, halign : Align, yexpand : Int32, yalign : Align)
      UI.grid_append(to_unsafe, ui_control(widget.control.to_unsafe), left, top, xspan, yspan, hexpand, halign, yexpand, yalign)
    end

    def to_unsafe
      return @this
    end
  end
end