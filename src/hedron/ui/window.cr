require "../bindings.cr"
require "../widget/container.cr"
require "../widget/control.cr"

module Hedron
  class Window < Control
    include SingleContainer

    @@size_change_box : Void*?
    @@close_box : Void*?

    gen_properties({
      "border"     => Bool,
      "margined"   => Bool,
      "fullscreen" => Bool,
      "title"      => String,
    })

    # Takes three arguments:
    # - `title`: The title of the window
    # - `dimensions`: Two Int32 values, {width, height}
    # - `menubar`: Whether the window has a menubar or not, defaults to false
    def initialize(title : String, dimensions : Tuple(Int32, Int32), menubar : Bool = false)
      @this = ui_control(UI.new_window(title, dimensions[0], dimensions[1], to_int(menubar)))
    end

    def initialize(@this); end

    # Takes 4 arguments:
    # ```
    # Window {
    #   @title: "Foo";
    #   @width: 640;
    #   @height: 480;
    #   @menubar: false;
    # }
    # ```
    def self.init_markup(args : MLArgs)
      return self.new(
        args["title"].as(String),
        {args["width"].as(Int32), args["height"].as(Int32)},
        args["menubar"].as(Bool)
      )
    end

    # Checks if the window has a border.
    def border? : Bool
      return !to_bool(UI.window_borderless(to_unsafe))
    end

    # Adds/removes borders in a window.
    def border=(is_borderless : Bool)
      UI.window_set_borderless(to_unsafe, to_int(!is_borderless))
    end

    # Checks whether the window is margined or not.
    def margined? : Bool
      return to_bool(UI.window_margined(to_unsafe))
    end

    # Adds/removes margins in a window.
    def margined=(is_margined : Bool)
      UI.window_set_margined(to_unsafe, to_int(is_margined))
    end

    # Fetches the current size of the window.
    def size : Tuple(Int32, Int32)
      UI.window_content_size(to_unsafe, out width, out height)
      return {width, height}
    end

    # Programmatically sets the size of a given window.
    def size=(dimensions : Tuple(Int32, Int32))
      UI.window_set_content_size(to_unsafe, dimensions[0], dimensions[1])
    end

    # Checks whether the window is in fullscreen mode or not.
    def fullscreen? : Bool
      return to_bool(UI.window_fullscreen(to_unsafe))
    end

    # Sets the window to fullscreen/non-fullscreen mode.
    def fullscreen=(is_fullscreen : Bool)
      UI.window_set_fullscreen(to_unsafe, to_int(is_fullscreen))
    end

    # Adds a child for the window.
    def child=(child : Widget)
      child.parent = self
      UI.window_set_child(to_unsafe, ui_control(child.control.as(Control).to_unsafe))
    end

    def title
      return UI.window_title(to_unsafe)
    end

    def title=(window_title : String)
      UI.window_set_title(to_unsafe, window_title)
    end

    def on_size_change(&block)
      on_size_change = block
    end

    def on_size_change=(proc : Proc(Window, Nil))
      boxed_data = ::Box.box(proc)
      @@size_change_box = boxed_data

      new_proc = ->(window : UI::Window*, data : Void*) {
        callback = ::Box(Proc(Window, Nil)).unbox(data)
        callback.call(Window.new(ui_control(window)))
      }

      UI.window_on_content_size_changed(to_unsafe, new_proc, boxed_data)
    end

    def on_close(&block : Window -> Bool)
      on_close = block
    end

    def on_close=(proc : Proc(Window, Bool))
      boxed_data = ::Box.box(proc)
      @@close_box = boxed_data

      new_proc = ->(window : UI::Window*, data : Void*) {
        callback = ::Box(Proc(Window, Bool)).unbox(data)
        return callback.call(Window.new(ui_control(window))) ? 1 : 0
      }

      UI.window_on_closing(to_unsafe, new_proc, boxed_data)
    end

    def error(title : String = "", description : String = "")
      UI.msg_box_error(to_unsafe, title, description)
    end

    def message(title : String = "", description : String = "")
      UI.msg_box(to_unsafe, title, description)
    end

    def to_unsafe
      return @this.as(UI::Window*)
    end
  end
end
