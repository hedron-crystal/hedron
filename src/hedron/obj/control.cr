require "../bindings.cr"

module Hedron
  abstract class Control
    property parent : Control?
    property stretchy : Bool = false

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
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

    def toplevel? : Bool
      return to_bool(UI.control_toplevel(ui_control(to_unsafe)))
    end

    def is_parent?(control : Control) : Bool
      return parent == control
    end

    def visible? : Bool
      return to_bool(UI.control_visible(ui_control(to_unsafe)))
    end

    abstract def to_unsafe
  end
end