require "../bindings.cr"
require "./control.cr"

module Hedron
  class Window < Control
    @name       : String
    @dimensions : Tuple(Int32, Int32)
    @menubar    : Bool

    @this : UI::Window*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize(@name, @dimensions, menubar : Bool = false)
      @menubar = menubar
      @this = UI.new_window(@name, @dimensions[0], @dimensions[1], to_int(@menubar))
    end

    def borderless? : Bool
      return to_bool(UI.window_borderless(to_unsafe))
    end

    def borderless=(is_borderless : Bool)
      UI.window_set_borderless(to_unsafe, to_int(is_borderless))
    end

    def margined? : Bool
      return to_bool(UI.window_margined(to_unsafe))
    end

    def margined=(is_margined : Bool)
      UI.window_set_margined(to_unsafe, to_int(is_margined))
    end

    def size : Tuple(Int32, Int32)
      UI.window_content_size(to_unsafe, out width, out height)
      return {width, height}
    end

    def size=(dimensions : Tuple(Int32, Int32))
      UI.window_set_content_size(to_unsafe, dimensions[0], dimensions[1])
    end

    def fullscreen? : Bool
      return to_bool(UI.window_fullscreen(to_unsafe))
    end

    def fullscreen=(is_fullscreen : Bool)
      UI.window_set_fullscreen(to_unsafe, to_int(is_fullscreen))
    end

    def child=(child : Control)
      child.parent = self
      UI.window_set_child(to_unsafe, ui_control(child.to_unsafe))
    end

    def title
      return UI.window_title(to_unsafe)
    end

    def title=(window_title : String)
      UI.window_set_title(to_unsafe, window_title)
    end

    def on_size_change=(proc : Proc(UI::Window*, Void*, Void))
      UI.window_on_content_size_changed(to_unsafe, proc, nil)
    end

    def on_close=(proc : Proc(UI::Window*, Void*, LibC::Int))
      UI.window_on_closing(to_unsafe, proc, nil)
    end

    def error(title : String = "", description : String = "")
      UI.msg_box_error(to_unsafe, title, description)
    end

    def message(title : String = "", description : String = "")
      UI.msg_box(to_unsafe, title, description)
    end

    def to_unsafe
      @this
    end
  end
end