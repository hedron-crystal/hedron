require "../bindings.cr"
require "./control.cr"

module Hedron
  class DateTimePicker < Control
    @this : UI::DateTimePicker*

    def initialize
      @this = UI.new_date_time_picker
    end

    def to_unsafe
      @this
    end
  end

  class DatePicker < DateTimePicker
    def initialize
      @this = UI.new_date_picker
    end
  end

  class TimePicker < DateTimePicker
    def initialize
      @this = UI.new_time_picker
    end
  end
end