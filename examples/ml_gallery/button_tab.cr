require "../../src/hedron.cr"

class ButtonTab < Hedron::Widget
  property window : Hedron::Window?
  @buttons = [] of Hedron::Button
  @counter = 0

  def initialize
    @display = Hedron::HDML.render <<-HDML
      VerticalBox #box {
        padded: true;
        stretchy: true;

        Label #label {
          @text: "You have made 0 new buttons.";
        }
      }
    HDML
  end

  def self.widget_name
    return "ButtonTab"
  end

  def self.init_markup
    return self.new
  end

  def new_button
    button = Hedron::HDML.render <<-HDML
      Button #btab#{@counter} {
        @text: "Button #{@counter}";
      }
    HDML
    button = button.widget.as(Hedron::Button)

    button.on_click do |this|
      index = @buttons.index(this).not_nil!

      @window.not_nil!.message(title: "You clicked a button!", description: "You clicked #{this.text}.")

      @buttons.delete_at(index)
      self.display["box"].as(Hedron::VerticalBox).delete_at(index + 1)
      this.destroy
    end

    @buttons.push(button)

    @counter += 1

    self.display["box"].as(Hedron::VerticalBox).push(button)
    self.display["label"].as(Hedron::Label).text = "You have made #{@counter} new buttons."
  end

  def index=(i : String)
    @index = i
    self.display["box"].index = i
  end
end
