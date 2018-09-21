require "./control"

module Hedron
  abstract class Box < Control
    def self.cast_ptr(ptr)
      return ptr.unsafe_as(Pointer(UI::Box))
    end
  end
end