require "../bindings.cr"

module Hedron
  enum MenuType
    About
    Preferences
    Quit
    Separator
  end

  class Menu
    @this : UI::Menu*

    def initialize(name : String)
      @this = UI.new_menu(name)
    end

    private def push_about
      UI.menu_append_about_item(to_unsafe)
    end

    private def push_preferences
      UI.menu_append_preferences_item(to_unsafe)
    end

    private def push_quit
      UI.menu_append_quit_item(to_unsafe)
    end

    private def push_separator
      UI.menu_append_separator(to_unsafe)
    end

    def push(menu_type : MenuType)
      case menu_type
        when MenuType::About       then push_about
        when MenuType::Preferences then push_preferences
        when MenuType::Quit        then push_quit
        when MenuType::Separator   then push_separator
      end
    end

    def to_unsafe
      return @this
    end
  end
end
