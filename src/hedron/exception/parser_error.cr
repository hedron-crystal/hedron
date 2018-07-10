module Hedron
  class LexError < Exception
    def initialize(message : String)
      super message
    end
  end

  class ParseError < Exception
    def initialize(message : String)
      super message
    end
  end

  class TypeParseError < Exception
    def initialize(message : String)
      super message
    end
  end
end
