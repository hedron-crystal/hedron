require "../bindings.cr"
require "../widget/control.cr"
require "../struct/align.cr"
require "../struct/side.cr"

module Hedron
  struct GridCell
    property size : Tuple(Int32, Int32)
    property expand : Tuple(Bool, Bool)
    property align_x : UI::Align
    property align_y : UI::Align

    def initialize(@size, @expand, @align_x : UI::Align, @align_y : UI::Align); end
  end

  class Grid < Control
    def initialize
      @this = ui_control(UI.new_grid)
    end

    def initialize(@this); end

    def insert(widget : Widget, next_to : Widget, side : Side, cell_info : GridCell)
      UI.grid_insert_at(
        to_unsafe,
        ui_control(widget.control.to_unsafe),
        ui_control(next_to.control.to_unsafe),
        side,
        cell_info.size[0], cell_info.size[1],
        to_int(cell_info.expand[0]), cell_info.align_x,
        to_int(cell_info.expand[1]), cell_info.align_y
      )
    end

    def padded : Bool
      return to_bool(UI.grid_padded(to_unsafe))
    end

    def padded=(is_padded : Bool)
      return UI.grid_set_padded(to_unsafe, to_int(is_padded))
    end

    def push(widget : Widget, coords : Tuple(Int32, Int32), cell_info : GridCell)
      UI.grid_append(
        to_unsafe,
        ui_control(widget.control.to_unsafe),
        coords[0], coords[1],
        cell_info.size[0], cell_info.size[1],
        to_int(cell_info.expand[0]), cell_info.align_x,
        to_int(cell_info.expand[1]), cell_info.align_y
      )
    end

    def to_unsafe
      return @this.as(UI::Grid*)
    end
  end
end
