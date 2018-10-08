module Hedron
  # A container that only has a single child.
  module SingleContainer
    @child : Control?

    abstract def child
    abstract def child=(control : Control?)
  end

  # A container that has multiple children.
  module Container
    @children = [] of Control

    delegate :index, :[], to: @children

    abstract def push(control : Control)
    abstract def delete_at(index : Int32)
  end

  # A container that has multiple children,
  # accessible by string indices instead of numbers.
  module IndexedContainer
  end
end
