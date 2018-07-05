require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class EditableCombobox < Widget
    include Control

    @@box : Void*?

    @this : UI::EditableCombobox*

    def initialize
      @this = UI.new_editable_combobox
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
        callback.call(EditableCombobox.new(combobox))
      }

      UI.editable_combobox_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def text : String
      UI.editable_combobox_text(to_unsafe)
    end

    def text=(ecbox_text : String)
      UI.editable_combobox_set_text(to_unsafe, ecbox_text)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end
end