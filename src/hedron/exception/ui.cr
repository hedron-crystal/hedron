module Hedron
  class UIException < Exception
    def initialize(control : Control, error : String)
      super "UI exception at #{control.class}: #{error}"
    end
  end
end