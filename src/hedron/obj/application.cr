require "../bindings.cr"

module Hedron
  class Application
    def initialize
      options = UI::InitOptions.new
      err = UI.init(pointerof(options))

      unless ui_nil?(err)
        puts "Error initializing ui: #{err}"
        exit 1
      end
    end

    def start
      UI.main
    end

    def on_stop=(proc : Proc(Void*, LibC::Int))
      UI.on_should_quit(proc, nil)
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