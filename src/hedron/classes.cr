require "./ui/*"
require "./widget/widget.cr"

module Hedron
  class Classes
    CONTROL_CLASSES = [
      Button, Checkbox, ColorButton, Combobox, DatePicker, DateTimePicker,
      EditableCombobox, Entry, FontButton, Group, HorizontalBox, HorizontalSeparator,
      Label, MultilineEntry, NonWrappingMultilineEntry, PasswordEntry, ProgressBar,
      RadioButtons, SearchEntry, Separator, Slider, Spinbox, Tab, VerticalBox,
      VerticalSeparator, Window
    ] of Widget.class

    class_property classes : Hash(String, Widget.class) =
      CONTROL_CLASSES.map { |wclass| {wclass.widget_name, wclass} }.to_h

    def self.add_class(wclass : Widget.class)
      @@classes[wclass.widget_name] = wclass
    end
  end
end
