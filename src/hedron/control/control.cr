module Hedron
  module Control
    setter stretchy : Bool = false

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def stretchy? : Bool
      return @stretchy
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

    def visible? : Bool
      return to_bool(UI.control_visible(ui_control(to_unsafe)))
    end

    def display : Control
      return self
    end

    def to_unsafe; end
  end
end
