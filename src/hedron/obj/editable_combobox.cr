require "../bindings.cr"
require "./control.cr"

module Hedron
  class EditableCombobox < Control
    @this : UI::EditableCombobox*

    def initialize
      @this = UI.new_editable_combobox
    end

    def add(choice : String)
      UI.editable_combobox_append(to_unsafe, choice)
    end

    def add_all(*choices : String)
      choices.each do |choice|
        add(choice)
      end
    end

    def on_change=(proc : Proc(UI::EditableCombobox*, Void*, Void))
      UI.editable_combobox_on_changed(to_unsafe, proc, nil)
    end

    def text : String
      UI.editable_combobox_text(to_unsafe)
    end

    def text=(ecbox_text : String)
      UI.editable_combobox_set_text(to_unsafe, ecbox_text)
    end

    def to_unsafe
      @this
    end
  end
end