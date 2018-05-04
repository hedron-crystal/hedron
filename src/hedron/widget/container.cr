require "./control.cr"

module Hedron
  abstract class Container < Control
    abstract def child=(child : Control)
  end

  abstract class MultipleContainer < Control
    abstract def add(child : Control)
  end

  abstract class IndexedContainer < Control
    abstract def []=(index : String, child : Control)
  end
end