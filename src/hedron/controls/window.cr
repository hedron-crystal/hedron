require "../native/*"
require "./control"

module Hedron
  struct MessageBox
    getter title : String
    getter description : String

    def initialize(@title, @description); end
  end

  class Window < Control
    include SingleContainer

    @@box : Void*?

    getter closing_flag = false

    private def ptr
      return self.to_unsafe.as(UI::Window*)
    end

    def initialize(title : String, size : Size, menubar : Bool = false)
      @this = Control.cast_ptr(UI.new_window(title, size.width, size.height, Control.to_int(menubar)))
    end

    Hedron.listener on_position_changed, Window
    Hedron.listener on_content_size_changed, Window

    def alert(box : MessageBox)
      UI.msg_box(ptr, box.title, box.description)
    end

    def borderless? : Bool
      return Control.to_bool(UI.window_borderless(ptr))
    end

    def borderless=(value : Bool)
      UI.window_set_borderless(ptr, Control.to_int(value))
    end

    def child : Control?
      return @child
    end

    def child=(value : Control?)
      UI.window_set_child(ptr, Control.to_ptr(value))
    end

    def error(box : MessageBox)
      UI.msg_box_error(ptr, box.title, box.description)
    end

    def fullscreen? : Bool
      return Control.to_bool(UI.window_fullscreen(ptr))
    end

    def fullscreen=(value : Bool)
      UI.window_set_fullscreen(ptr, Control.to_int(value))
    end

    def margined? : Bool
      return Control.to_bool(UI.window_margined(ptr))
    end

    def margined=(value : Bool)
      UI.window_set_margined(ptr, Control.to_int(value))
    end

    def on_closing(&block : -> Bool)
      boxed_data = ::Box.box(block)
      @@box = boxed_data

      new_proc = ->(this : UI::Window*, data : Void*) {
        callback = ::Box(Proc(Bool)).unbox(data)
        return Control.to_int(callback.call)
      }

      UI.window_on_closing(ptr, new_proc, boxed_data)
      @closing_flag = true
    end

    def open_file : String
      path = UI.open_file(ptr)
      return path.null? ? "" : String.new(path)
    ensure
      UI.free_text(path)
    end

    def save_file : String
      path = UI.save_file(ptr)
      return path.null? ? "" : String.new(path)
    ensure
      UI.free_text(path)
    end

    def size : Size
      UI.window_content_size(ptr, out width, out height)
      return Size.new(width, height)
    end

    def size=(value : Size)
      UI.window_set_content_size(ptr, value.width, value.height)
    end

    def title : String
      return Control.to_str(UI.window_title(ptr))
    end

    def title=(value : String)
      UI.window_set_title(value)
    end
  end
end
