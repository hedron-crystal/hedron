require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class DateTimePicker < Control
    gen_properties({"stretchy" => Bool})

    def initialize
      @this = ui_control(UI.new_date_time_picker)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def to_unsafe
      return @this.as(UI::DateTimePicker*)
    end
  end

  class DatePicker < DateTimePicker
    def initialize
      @this = ui_control(UI.new_date_picker)
    end
  end

  class TimePicker < DateTimePicker
    def initialize
      @this = ui_control(UI.new_time_picker)
    end
  end
end
