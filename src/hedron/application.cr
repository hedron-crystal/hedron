require "./bindings.cr"

module Hedron
  class Application
    @@box : Void*?

    def initialize
      options = UI::InitOptions.new
      err = UI.init(pointerof(options))

      unless ui_nil?(err)
        raise UIError.new("Error initializing UI: #{err}")
      end
    end

    def start
      UI.main
    end

    def on_stop(&block)
      on_stop = block
    end

    def on_stop=(proc : Proc(Bool))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(data : Void*) {
        callback = ::Box(Proc(Bool)).unbox(data)
        return callback.call ? 1 : 0
      }

      UI.on_should_quit(new_proc, boxed_data)
    end

    def stop
      UI.quit
    end

    def close
      UI.uninit
    end

    def open_file(window : Window) : String?
      chars = UI.open_file(window.to_unsafe)
      return ui_nil?(chars) ? nil : String.new(chars)
    end

    def save_file(window : Window) : String?
      chars = UI.save_file(window.to_unsafe)
      return ui_nil?(chars) ? nil : String.new(chars)
    end
  end
end