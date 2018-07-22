module Hedron
  # Representation of colour in Hedron, used in `Hedron::ColorButton`.
  struct Color
    getter red : UInt8
    getter green : UInt8
    getter blue : UInt8
    getter alpha : UInt8

    def initialize(@red, @green, @blue, @alpha); end
  end
end
