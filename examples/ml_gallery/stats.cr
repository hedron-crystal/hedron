require "../../src/hedron.cr"

class Stats < Hedron::Widget
  def initialize; end
  def init_markup; end

  def display : Hedron::Control
    return Hedron::HDML.render(
      Hedron::HDML.create_widget(
        class_name: "Tab",
        id: "tab",
        index: @index,
        values: {
          "padded" => true,
          "stretchy" => true
        },
        children: [
          Hedron::HDML.create_widget(
            class_name: "Label",
            id: "label",
            index: nil,
            values: {"@text" => "You have clicked this button 0 times"},
            children: nil
          ), Hedron::HDML.create_widget(
            class_name: "Button",
            id: "reset",
            index: nil,
            values: {"@text" => "Resest stats"},
            children: nil
          )
        ]
      )
    )["tab"].as(Hedron::Tab)
  end
end
