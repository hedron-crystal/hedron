require "./control"

module Hedron
  class Area < Control
    module Handler
      abstract def draw(params : DrawParams)
      abstract def mouse_event(event : MouseEvent)
      abstract def mouse_crossed(left : Int32)
      abstract def drag_broken
      abstract def key_event(event : KeyEvent) : Int32
    end

    @handler : UI::AreaHandler

    def initialize
      @handler = UI::AreaHandler.new
      @this = Control.cast_ptr(UI.new_area(pointerof(@handler)))
    end

    def handler=(handler : Handler)
      @@new_handler = handler

      @handler.draw = ->(ah : UI::AreaHandler*, a : UI::Area*, params : UI::AreaDrawParams*) {
        @@new_handler.draw(DrawParams.new(params))
      }
      @handler.mouse_event = ->(ah : UI::AreaHandler*, a : UI::Area*, event : UI::AreaMouseEvent*) {
        @@new_handler.mouse_event(MouseEvent.new(event))
      }
      @handler.mouse_crossed = ->(ah : UI::AreaHandler*, a : UI::Area*, left : Int32) {
        @@new_handler.mouse_crossed(left)
      }
      @handler.drag_broken = ->(ah : UI::AreaHandler*, a : UI::Area*) {
        @@new_handler.drag_broken
      }
      @handler.key_event = ->(ah : UI::AreaHandler*, a : UI::Area*, event : UI::AreaKeyEvent*) {
        return @@new_handler.key_event(KeyEvent.new(event))
      }
    end
  end
end
