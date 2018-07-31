require "../bindings.cr"
require "./widget.cr"

module Hedron
  private class Control < Widget
    property stretchy = false

    @this : UI::Control*

    def initialize(@this); end

    def ==(control : Control) : Bool
      return to_unsafe == control.to_unsafe
    end

    def destroy
      UI.control_destroy(ui_control(to_unsafe))
    end

    def disable
      UI.control_disable(ui_control(to_unsafe))
    end

    def dup
      return self.new(@this)
    end

    def enable
      UI.control_enable(ui_control(to_unsafe))
    end

    def enabled? : Bool
      return to_bool(UI.control_enabled(ui_control(to_unsafe)))
    end

    def enabled_to_user? : Bool
      return to_bool(UI.control_enabled(ui_control(to_unsafe)))
    end

    def handle : Uint32
      return UI.control_handle(ui_control(to_unsafe))
    end

    def show
      UI.control_show(ui_control(to_unsafe))
    end

    def toplevel? : Bool
      return to_bool(UI.control_toplevel(ui_control(to_unsafe)))
    end

    def visible? : Bool
      return to_bool(UI.control_visible(ui_control(to_unsafe)))
    end

    def to_unsafe; end
  end
end
