require "../bindings.cr"
require "./control/*"

module Hedron
  class Tab < IndexedContainer
    include ControlMethods

    @this : UI::Tab*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize
      @this = UI.new_tab
    end

    def self.init_markup
      return self.new
    end

    def []=(name : String, control : Control)
      UI.tab_append(to_unsafe, name, ui_control(control.to_unsafe))
    end

    def delete(index : Int32)
      UI.tab_delete(to_unsafe, index)
    end

    def insert(control : Control, index : Int32, name : String)
      UI.tab_insert_at(to_unsafe, name, index, control)
    end

    def pages : Int32
      UI.tab_num_pages(to_unsafe)
    end

    def page_margined?(page : Int32) : Bool
      return to_bool(UI.tab_margined(to_unsafe), page)
    end

    def page_margined(page : Int32, is_margined : Bool)
      UI.tab_set_margined(to_unsafe, to_int(is_margined))
    end

    def to_unsafe
      return @this
    end
  end
end