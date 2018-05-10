require "../../src/hedron.cr"

class MLGallery
  @@main : Hedron::Parsed?
  @@window : Hedron::Window?

  @counter = 0

  def on_closing(this)
    this.destroy
    @@app.not_nil!.stop
    return false
  end

  def should_quit
    @@window.not_nil!.destroy
    return true
  end

  def initialize
    @@app = Hedron::Application.new
    app = @@app.not_nil!
    app.on_stop = ->should_quit

    parser = Hedron::Parser.new
    @@main = parser.parse("./examples/ml_gallery/main.hdml")
    main = @@main.not_nil!

    @@window = main["window"].as(Hedron::Window)
    window = @@window.not_nil!
    window.on_close = ->on_closing(Hedron::Window)

    main["button"].as(Hedron::Button).on_click do |button|
      @counter += 1
      label = @@main.not_nil!["label"].as(Hedron::Label)
      label.text = "You have clicked the button #{@counter} times."
    end

    window.show

    app.start
    app.close
  end
end

MLGallery.new