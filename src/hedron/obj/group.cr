require "../bindings.cr"
require "./control.cr"

module Hedron
  class Group < Control
    @name : String
    @this : UI::Group*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize(@name)
      @this = UI.new_group(@name)
    end

    def margined : Bool
      return to_bool(UI.group_margined(to_unsafe))
    end

    def margined=(is_margined : Bool)
      UI.group_set_margined(to_unsafe, to_int(is_margined))
    end

    def title : String
      return UI.group_title(to_unsafe)
    end

    def title=(group_title : String)
      UI.group_set_title(to_unsafe, group_title)
    end

    def child=(child : Control)
      child.parent = self
      UI.group_set_child(to_unsafe, ui_control(child.to_unsafe))
    end

    def to_unsafe
      @this
    end
  end
end