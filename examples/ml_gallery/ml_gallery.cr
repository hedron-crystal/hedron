require "../../src/hedron.cr"
require "./button_tab.cr"

class MLGallery < Hedron::Application
  @@main : Hedron::Render?
  @@window : Hedron::Window?

  def on_closing(this)
    this.destroy
    self.stop
    return false
  end

  def should_quit
    @@window.not_nil!.destroy
    return true
  end

  def initialize
    super
    self.on_stop = ->should_quit

    Hedron::Classes.add_class(ButtonTab)
    @@main = Hedron::HDML.render_file("./examples/ml_gallery/main.hdml")
    main = @@main.not_nil!

    @@window = main["window"].widget.as(Hedron::Window)
    window = @@window.not_nil!
    window.on_close = ->on_closing(Hedron::Window)

    main["button"].widget.as(Hedron::Button).on_click do |button|
      stats = @@main.not_nil!["btab"].widget.as(ButtonTab)
      stats.new_button
    end

    window.show
  end
end

gallery = MLGallery.new
gallery.start
gallery.close
