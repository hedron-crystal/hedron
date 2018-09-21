require "../native/bindings"

module Hedron
  private class Control
    @this : UI::Control*

    ## Static methods

    # Converts a pointer which is a subclass of Control into
    # a Control pointer.
    def self.cast_ptr(ptr)
      return ptr.unsafe_as(Pointer(UI::Control))
    end

    # Converts a C integer value designated as a boolean
    # (i.e. 0 or 1) into a proper Crystal Bool
    def self.to_bool(int) : Bool
      return int == 1
    end

    # Converts a Crystal Bool to either 0 or 1
    def self.to_int(bool) : Int32
      return bool ? 1 : 0
    end

    ## Overriding default object methods

    # Generates a new instance of `Control` based on its
    # LibUI pointer. This method is protected because it
    # should only be accessed internally.
    protected def initialize(@this); end

    # Checks for equality between two Controls.
    def ==(rhs)
      rhs.to_unsafe == @this
    end

    # Duplicates a selected Control.
    def dup
      Control.new(self.to_unsafe)
    end

    # Override `finalize`: this is called when the function is
    # freed by the GC.
    def finalize
      UI.free_control(self.to_unsafe)
    end

    # `Control#to_unsafe` must be implemented by all subclasses
    # of Control.
    def to_unsafe
      return @this
    end

    ## Specific methods

    # Removes a parent form the Control. `Control#clear_parent` raises an
    # error when it is called while Control does not have a parent.
    def clear_parent
      if self.parent.null?
        raise UIException.new(self, "cannot clear a Control that doesn't have a parent.")
      end

      UI.control_set_parent(self.to_unsafe, Pointer.null)
    end

    # Destroys the Control. Raises an exception if the control has
    # a parent.
    def destroy
      unless self.parent.null?
        raise UIException.new(self, "cannot destroy Control while it still has a parent.")
      end

      UI.control_destroy(self.to_unsafe)
    end

    # Disables the Control.
    def disable
      UI.control_disable(self.to_unsafe)
    end

    # Enables the Control.
    def enable
      UI.control_enable(self.to_unsafe)
    end

    # Makes the control enabled or disabled via operator
    # overloading of `enabled`.
    def enabled=(bool)
      return if self.enabled? == bool
      bool ? self.disable : self.enable
    end

    # Returns whether or not the Control is enabled.
    def enabled?(parents = false) : Bool
      if parents
        return Control.to_bool(UI.control_enabled_to_user(self.to_unsafe))
      else
        return Control.to_bool(UI.control_enabled(self.to_unsafe))
      end
    end

    # Hide the Control from the user.
    def hide
      UI.control_hide(self.to_unsafe)
    end

    # Returns the parent of the Control. Returns `nil` when the Control
    # does not have a parent.
    def parent : Control?
      ptr = UI.control_parent(self.to_unsafe)
      return (ptr == Pointer.null ? nil : Control.new(ptr))
    end

    # Given another Control, sets that control to be the parent of our Control.
    # Raises an error when this is called on a toplevel Control or when Control
    # already has a parent.
    def parent=(parent : Control)
      if self.toplevel?
        raise UIException.new(self, "cannot give a toplevel Control a parent.")
      elsif !parent.nil?
        raise UIException.new(self, "cannot give a Control a parent when it already has one.")
      end

      UI.control_set_parent(self.to_unsafe, parent.to_unsafe)
    end

    # Shows the Control to the user.
    def show
      UI.control_show(self.to_unsafe)
    end

    # Returns whether or not the Control is a toplevel Control.
    def toplevel? : Bool
      Control.to_bool(UI.control_toplevel(self.to_unsafe))
    end

    # Changes the control's visibility via operator overloading
    # of `visible`.
    def visible=(bool)
      return if self.visible? == bool
      bool ? self.show : self.hide
    end

    # Returns whether the Control is visible or not.
    def visible? : Bool
      Control.to_bool(UI.control_visible(self.to_unsafe))
    end
  end
end