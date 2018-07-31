require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class EditableCombobox < Control
    @@box : Void*?

    gen_properties({"stretchy" => Bool, "text" => String})

    def initialize
      @this = ui_control(UI.new_editable_combobox)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def choices=(choices : Array(String))
      choices.each do |choice|
        UI.editable_combobox_append(to_unsafe, choice)
      end
    end

    def on_select(&block : EditableCombobox ->)
      self.on_select = block
    end

    def on_select=(proc : Proc(EditableCombobox, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(combobox : UI::EditableCombobox*, data : Void*) {
        callback = ::Box(Proc(EditableCombobox, Nil)).unbox(data)
        callback.call(EditableCombobox.new(ui_control(combobox)))
      }

      UI.editable_combobox_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def text : String
      UI.editable_combobox_text(to_unsafe)
    end

    def text=(ecbox_text : String)
      UI.editable_combobox_set_text(to_unsafe, ecbox_text)
    end

    def to_unsafe
      return @this.as(UI::EditableCombobox*)
    end
  end
end
