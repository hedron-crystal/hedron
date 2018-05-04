module Hedron
  class LexError < Exception
    def initialize(message : String)
      super message
    end
  end
end