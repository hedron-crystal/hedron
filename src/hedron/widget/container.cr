require "./widget.cr"

module Hedron
  abstract class SingleContainer < Widget
    abstract def child=(child : Widget)
  end

  abstract class MultipleContainer < Widget
    abstract def add(child : Widget)
  end

  abstract class IndexedContainer < Widget
    abstract def []=(index : String, child : Widget)
  end
end
