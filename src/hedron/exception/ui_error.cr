module Hedron
  class UIError < Exception
    def initialize(message : String)
      super message
    end
  end
end
