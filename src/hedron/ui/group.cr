require "../bindings.cr"
require "../control/*"
require "../widget/*"

module Hedron
  class Group < SingleContainer
    include Control

    @this : UI::Group*

    private def to_int(bool : Bool) : Int32
      return bool ? 1 : 0
    end

    private def to_bool(int : Int32) : Bool
      return int == 1 ? true : false
    end

    def initialize(title : String)
      @this = UI.new_group(title)
    end

    def self.init_markup(args : MLArgs)
      return self.new(args["title"].as(String))
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

    def child=(child : Widget)
      child.parent = self
      UI.group_set_child(to_unsafe, ui_control(child.display.as(Control).to_unsafe))
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "margined" => Bool, "title" => String})
    end

    def to_unsafe
      return @this
    end
  end
end