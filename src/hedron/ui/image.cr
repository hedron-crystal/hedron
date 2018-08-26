require "stumpy_png"
require "../bindings.cr"

module Hedron
  class Image
    @this : UI::Image*

    def initialize(width : Int32, height : Int32)
      @this = UI.new_image(width, height)
    end

    def initialize(@this); end

    def push(pixels : Array(UInt32), width : Int32, height : Int32, byte_stride : Int32)
      UI.image_append(to_unsafe, pixels.to_unsafe, width, height, byte_stride)
    end

    def push_png(filename : String)
      puts filename
      png = StumpyPNG.read(filename)

      pixels = png.pixels.map do |pixel|
        rgba = pixel.to_rgba
        Color.new(rgba[0], rgba[1], rgba[2], rgba[3]).to_u32
      end.to_a

      width = png.width
      height = png.height
      stride = width * 4

      push(pixels, width, height, stride)
    end

    def to_unsafe
      return @this
    end
  end
end
