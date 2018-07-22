require "./bindings.cr"

module Hedron
  private module Control
    setter stretchy = false

    def ==(control : Control) : Bool
      return to_unsafe == control.to_unsafe
    end

    def destroy
      UI.control_destroy(ui_control(to_unsafe))
    end

    def disable
      UI.control_disable(ui_control(to_unsafe))
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

    def stretchy? : Bool
      return @stretchy
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
