require "../bindings.cr"
require "./menu.cr"

module Hedron
  class MenuItem
    @@box : Void*?
    @this : UI::MenuItem*

    @menu : Menu
    @name : String

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize(@menu, @name)
      @this = UI.menu_append_item(@menu.to_unsafe, @name)
    end

    def enable
      UI.menu_item_enable(to_unsafe)
    end

    def disable
      UI.menu_item_disable(to_unsafe)
    end

    def on_click(&block)
      self.on_click = block
    end

    def on_click=(proc : Proc(MenuItem, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@item = self
      new_proc = ->(item : UI::MenuItem*, window : UI::Window*, data : Void*) {
        callback = ::Box(Proc(MenuItem, Nil)).unbox(data)
        callback.call(@@item.not_nil!)
      }
      UI.menu_item_on_clicked(to_unsafe, new_proc, boxed_data)
    end

    def to_unsafe
      return @this
    end
  end

  class MenuCheckItem < MenuItem
    def initialize(@menu, @name)
      @this = UI.menu_append_check_item(@menu.to_unsafe, @name)
    end

    def checked? : Bool
      return to_bool(UI.menu_item_checked(to_unsafe))
    end

    def checked=(is_checked : Bool)
      UI.menu_item_set_checked(to_unsafe, to_int(is_checked))
    end

    def to_unsafe
      return @this
    end
  end
end
