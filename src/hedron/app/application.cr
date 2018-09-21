require "../native/core"

module Hedron
  class Application
    class_getter! main_window : Window
    @@created = false
    
    def initialize
      if @@created
        raise UIException.new(self, "cannot create more than 1 application.")
      end

      options = UI::InitOptions.new
      error = UI.init(pointerof(options))

      unless error.null?
        UI.free_init_error(error)
        raise UIException.new(self, "cannot initialize Application: #{error}")
      end

      @@created = true

      self.should_quit do
        self.main_window.destroy
        return true
      end
    end

    def run(main_window : Window)
      @@main_window = main_window
      self.main_window.show

      UI.main
    end

    # Called when the OS attempts to quit the application.
    # If should_quit returns true, then the application exits.
    # If should_quit returns false, then the application stays
    # open.
    def should_quit(&block : -> Bool)
      boxed_data = ::Box.box(block)
      @@box = boxed_data

      new_proc = ->(data : Void*) {
        callback = ::Box(Proc(Bool)).unbox(data)
        return callback.call ? 1 : 0
      }

      UI.on_should_quit(new_proc, boxed_data)
    end

    def quit
      UI.quit
    end
  end
end