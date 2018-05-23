require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class DateTimePicker < Widget
    include ControlMethods

    @this : UI::DateTimePicker*

    def initialize
      @this = UI.new_date_time_picker
    end

    def self.init_markup
      return self.new
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool})
    end
    
    def to_unsafe
      return @this
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