require "../bindings.cr"

module Hedron
  abstract class SuperMenuItem
    @this    : UI::MenuItem*?
    @enabled : Bool = true

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    abstract def add_menu(menu : UI::Menu*)

    def enable
      @this.is_a?(Nil) ? (@enabled = true) : UI.menu_item_enable(to_unsafe)
    end

    def disable
      @this.is_a?(Nil) ? (@enabled = false) : UI.menu_item_disable(to_unsafe)
    end

    def checked? : Bool
      to_bool(UI.menu_item_checked(to_unsafe))
    end

    def checked=(is_checked : Bool)
      UI.menu_item_set_checked(to_int(is_checked))
    end

    def to_unsafe
      @this.not_nil!
    end
  end

  class MenuItem < SuperMenuItem
    @@box : Void*?

    @name : String
    @proc : Proc(MenuItem, Nil)

    @state : Bool = true

    def initialize(@name, on_click = ->(this : MenuItem) { })
      @proc = on_click
    end

    def add_menu(menu : UI::Menu*)
      @this = UI.menu_append_item(menu, @name)
      
      boxed_data = ::Box.box(@proc)
      @@box = boxed_data
      @@item = self

      new_proc = ->(item : UI::MenuItem*, window : UI::Window*, data : Void*) {
        callback = ::Box(Proc(MenuItem, Nil)).unbox(data)
        callback.call(@@item.not_nil!)
      }

      UI.menu_item_on_clicked(to_unsafe, new_proc, boxed_data)
      disable unless @enabled
    end
  end

  class MenuCheckItem < SuperMenuItem
    @name : String

    def initialize(@name); end

    def add_menu(menu : UI::Menu*)
      @this = UI.menu_append_check_item(menu, @name)
      disable unless @enabled
    end
  end
end