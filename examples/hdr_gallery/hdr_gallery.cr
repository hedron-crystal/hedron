require "../../src/hedron.cr"

class HdrGallery
  def initialize
    @@app = Hedron::Application.new
    app = @@app.not_nil!

    @@window = Hedron::Window.new
    window = @@window.not_nil!
  end
end

HdrGallery.new