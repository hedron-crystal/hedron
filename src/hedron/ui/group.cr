require "../bindings.cr"
require "../widget/container.cr"
require "../widget/control.cr"

module Hedron
  class Group < Control
    include SingleContainer

    gen_properties({"stretchy" => Bool, "margined" => Bool, "title" => String})

    def initialize(title : String)
      @this = ui_control(UI.new_group(title))
    end

    def initialize(@this); end

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
      UI.group_set_child(to_unsafe, ui_control(child.control.to_unsafe))
    end

    def to_unsafe
      return @this.as(UI::Group*)
    end
  end
end
