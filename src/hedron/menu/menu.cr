require "../bindings.cr"

module Hedron
  class Menu
    @this : UI::Menu*

    def initialize(name : String)
      @this = UI.new_menu(name)
    end

    def add_separator
      UI.menu_append_separator(to_unsafe)
    end

    def add_quit
      UI.menu_append_quit_item(to_unsafe)
    end

    def add_preferences
      UI.menu_append_preferences_item(to_unsafe)
    end

    def add_about
      UI.menu_append_about_item(to_unsafe)
    end

    def to_unsafe
      return @this
    end
  end
end
