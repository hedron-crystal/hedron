require "../bindings.cr"
require "../widget/container.cr"
require "../widget/control.cr"

module Hedron
  class Tab < Control
    include IndexedContainer

    gen_properties({"stretchy" => Bool})

    def initialize
      @this = ui_control(UI.new_tab)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def []=(name : String, child : Widget)
      UI.tab_append(to_unsafe, name, ui_control(child.control.as(Control).to_unsafe))
    end

    def delete_at(index : Int32)
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
      return @this.as(UI::Tab*)
    end
  end
end
