require "./control"

module Hedron
    class ProgressBar < Control

        @currentValue = 0

        private def ptr
            @this.as(UI::ProgressBar*)
        end
    
        def initialize
            @this = Control.cast_ptr(UI.new_progress_bar)
        end

        protected def initialize(@this); end

        def value : Int32
            @currentValue
            # return UI.progress_bar_value(ptr) # For some reason this wont return a number higher than 56
        end

        def value=(value : Int32)
            unless value < 0 || value > 100
                @currentValue = value
                UI.progress_bar_set_value(ptr, value)
            end
        end
    end
end