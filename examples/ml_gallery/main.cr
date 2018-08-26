require "../../src/hedron.cr"
require "./button_tab.cr"

class MLGallery < Hedron::Application
  @window : Hedron::Window?

  def on_closing(this)
    this.destroy
    self.stop
    return false
  end

  def should_quit
    @window.not_nil!.destroy
    return true
  end

  def draw
    self.on_stop = ->should_quit

    Hedron::Classes.add_class(ButtonTab)
    main = Hedron::HDML.render_file("./examples/ml_gallery/main.hdml")

    @window = main["window"].as(Hedron::Window)
    @window.not_nil!.on_close = ->on_closing(Hedron::Window)

    main["btab"].as(ButtonTab).window = @window.not_nil!

    main["button"].as(Hedron::Button).on_click do |button|
      stats = main["btab"].as(ButtonTab)
      stats.new_button
    end

    @window.not_nil!.show
  end
end

gallery = MLGallery.new
gallery.start
gallery.close
