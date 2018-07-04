require "../src/hedron.cr"

class Test < Hedron::Application
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

    @@window = Hedron::Window.new("Test", {640, 480}, menubar: true)
    window = @@window.not_nil!
    window.margined = true
    window.on_close = ->on_closing(Hedron::Window)

    box = Hedron::VerticalBox.new
    box.padded = true
    box.stretchy = true
    window.child = box

    (0...3).each do |n|
      button = Hedron::Button.new("Button #{n}")
      button.on_click do |this|
        puts this.text
      end
      box.add(button)
    end

    window.show
  end
end

test = Test.new
test.start
test.close