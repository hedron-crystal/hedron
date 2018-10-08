module Hedron
  class UIException < Exception
    def initialize(ui : Control | App, error : String)
      super "UI exception at #{ui.class}: #{error}"
    end
  end
end