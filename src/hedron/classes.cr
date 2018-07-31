require "./ui/*"
require "./widget/widget.cr"

module Hedron
  # Contains a list of classes that are used by the internal
  # parser for HDML.
  class Classes
    CONTROL_CLASSES = [
      Button, Checkbox, ColorButton, Combobox, DatePicker, DateTimePicker,
      EditableCombobox, Entry, FontButton, Group, HorizontalBox, HorizontalSeparator,
      Label, MultilineEntry, NonWrappingMultilineEntry, PasswordEntry, ProgressBar,
      RadioButtons, SearchEntry, Slider, Spinbox, Tab, VerticalBox,
      VerticalSeparator, Window,
    ] of Widget.class

    # Contains a list of all classes used by the parser,
    # custom classes that extend Widget can be added to this
    # variable.
    class_getter classes : Hash(String, Widget.class) = CONTROL_CLASSES.map { |wclass| {wclass.widget_name, wclass} }.to_h

    # Used when a custom class is to be added to `Hedron::Parser`.
    # The class added must extend `Hedron::Widget`.
    #
    # ```crystal
    # Hedron::Classes.add_class(Foo) # Foo < Hedron::Widget
    # # Now you can use Foo in your HDML files and eval statements!
    # ```
    def self.add_class(wclass : Widget.class)
      @@classes[wclass.widget_name] = wclass
    end
  end
end
