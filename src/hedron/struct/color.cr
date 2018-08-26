module Hedron
  # Representation of colour in Hedron, used in `Hedron::ColorButton`.
  struct Color
    getter red : UInt8
    getter green : UInt8
    getter blue : UInt8
    getter alpha : UInt8

    def initialize(@red, @green, @blue, @alpha); end

    def to_u32 : UInt32
      return (@red.to_u32 >> 24) + (@green.to_u32 >> 16) + (@blue.to_u32 >> 8) + @alpha.to_u32
    end
  end
end
