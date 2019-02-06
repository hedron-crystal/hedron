require "./bindings.cr"

module Hedron
  # A basic class that allows users to create their own Hedron apps.
  # To create a Hedron app, extend `Hedron::Application` and place all of
  # your UI instructions in the `draw` method.
  abstract class Application
    @@box : Void*?

    # Override this method to draw UI to the application itself.
    #
    # ```crystal
    # class Foo < Hedron::Application
    #   def draw
    #     # Draw all of your UI here
    #   end
    # end
    # ```
    abstract def draw

    def initialize
      options = UI::InitOptions.new
      err = UI.init(pointerof(options))

      unless ui_nil?(err)
        raise UIError.new("Error initializing UI: #{String.new(err)}")
      end
    end

    # Start up the application.
    def start
      UI.main
    end

    # Execute a set of instructions when the application
    # is stopped.
    #
    # ```crystal
    # on_stop do
    #   # Execute all instructions when stopped
    # end
    # ```
    def on_stop(&block)
      self.on_stop = block
    end

    # Same as `on_stop(&block)`, except a function
    # can be passed through this.
    #
    # ```crystal
    # on_stop = foo # Here, foo is a Proc
    # ```
    def on_stop=(proc : Proc(Bool))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(data : Void*) {
        callback = ::Box(Proc(Bool)).unbox(data)
        return callback.call ? 1 : 0
      }

      UI.on_should_quit(new_proc, boxed_data)
    end

    # Stop the application
    def stop
      UI.quit
    end

    # Close the application
    def close
      UI.uninit
    end

    # Create a prompt that opens a file. Returns the file name.
    def open_file(window : Window) : String?
      chars = UI.open_file(window.to_unsafe)
      return ui_nil?(chars) ? nil : String.new(chars)
    end

    # Create a prompt that saves a file. Returns the file name.
    def save_file(window : Window) : String?
      chars = UI.save_file(window.to_unsafe)
      return ui_nil?(chars) ? nil : String.new(chars)
    end
  end
end
