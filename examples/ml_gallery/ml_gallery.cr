require "../../src/hedron.cr"

class MLGallery
  def initialize
    @@app = Hedron::Application.new
    app = @@app.not_nil!

    @@window = Hedron::Window.new("ML Gallery", {640, 480}, menubar: true)
    window = @@window.not_nil!
  end
end

MLGallery.new