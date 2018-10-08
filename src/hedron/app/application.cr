module Hedron
  # The main application class of Hedron, which is
  # a singleton class (no two apps may be run at the same
  # time).
  class App
    @@box : Void*?
    @@instance : App?
    class_getter! window : Window

    # A flag within `App` to detect whether the user has
    # implemented their own `shutdown` method or not
    getter shutdown_flag = false

    # A private method that starts a new App class.
    def initialize
      options = UI::InitOptions.new
      error = UI.init(pointerof(options))

      # If error is null, we know there's no error so we don't
      # have to raise. However, if there is an error:
      unless error.null?
        # We convert it to an exception
        raise UIException.new(self, "cannot open App: #{error}")
      end
    ensure
      # For some reason, `error` is nilable here, so we catch that
      # in the `ensure` block
      UI.free_init_error(error) unless error.is_a?(Nil)
    end

    # Garbage collection
    def finalize
      UI.uninit
    end

    # Returns the single instance of App within the program.
    def self.main : App
      if @@instance.nil?
        @@instance = App.new
      end

      return @@instance.not_nil!
    end

    # This function is called every time the OS wants to
    # shut down the App. `block` can dictate what happens when
    # `App#on_should_shutdown` is called:
    # - if `block` returns `true`, the App shuts down normally.
    # - if `block` returns `false`, the App doesn't shut down.
    def on_should_shutdown(&block : -> Bool)
      boxed_data = ::Box.box(block)
      @@box = boxed_data

      new_proc = ->(data : Void*) {
        callback = ::Box(Proc(Bool)).unbox(data)
        return Control.to_int(callback.call)
      }

      UI.on_should_quit(new_proc, boxed_data)
      shutdown_flag = true
    end

    # Given a Window, starts the App with that chosen Window
    # as the main Window.
    def run(window : Window)
      # If the `window` is not toplevel, that must mean it has
      # a parent. If it has a parent, we can't initialise it, therefore
      # raise an error.
      unless window.toplevel?
        raise UIException.new(window, "App can only be initialised with top-level Window")
      end

      # Set `@@window` to the window that we provide
      @@window = window

      # If the user hasn't set their own shutdown command:
      unless App.main.shutdown_flag
        # Set default `on_should_shutdown` to destroy the main Window
        # and shut down the app normally
        App.main.on_should_shutdown do
          App.window.destroy
          true
        end
      end

      # If the user hasn't set their own closing command for the
      # main window:
      unless App.window.closing_flag
        # Set the `on_closing` method in the main Window to shutdown the app
        # and close the Window
        App.window.on_closing do
          App.main.shutdown
          true
        end
      end

      # Display our window
      App.window.show
      # Start the main loop
      UI.main
    end

    # Shuts down the app
    def shutdown
      UI.quit
    end
  end
end
