require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Combobox < Control
    @@box : Void*?

    gen_properties({"stretchy" => Bool, "selected" => Int32})

    def initialize
      @this = ui_control(UI.new_combobox)
    end

    def initialize(@this); end

    def self.init_markup
      return self.new
    end

    def choices=(choices : Array(String))
      choices.each do |choice|
        UI.combobox_append(to_unsafe, choice)
      end
    end

    def on_select(&block : Combobox ->)
      self.on_select = block
    end

    def on_select=(proc : Proc(Combobox, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data

      new_proc = ->(combobox : UI::Combobox*, data : Void*) {
        callback = ::Box(Proc(Combobox, Nil)).unbox(data)
        callback.call(Combobox.new(ui_control(combobox)))
      }

      UI.combobox_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def selected : Int32
      return UI.combobox_selected(to_unsafe)
    end

    def selected=(index : Int32)
      UI.combobox_set_selected(to_unsafe, index)
    end

    def to_unsafe
      return @this.as(UI::Combobox*)
    end
  end
end
