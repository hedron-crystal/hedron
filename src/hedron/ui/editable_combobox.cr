require "../bindings.cr"
require "./control/*"
require "./widget/*"

module Hedron
  class EditableCombobox < Widget
    include ControlMethods

    @@box : Void*?

    @this : UI::EditableCombobox*

    def initialize
      @this = UI.new_editable_combobox
    end

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
      @@ecombobox = self

      new_proc = ->(combobox : UI::EditableCombobox*, data : Void*) {
        callback = ::Box(Proc(EditableCombobox, Nil)).unbox(data)
        callback.call(@@ecombobox.not_nil!)
      }

      UI.editable_combobox_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def text : String
      UI.editable_combobox_text(to_unsafe)
    end

    def text=(ecbox_text : String)
      UI.editable_combobox_set_text(to_unsafe, ecbox_text)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end
end