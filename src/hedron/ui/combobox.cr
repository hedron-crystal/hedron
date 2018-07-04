require "../bindings.cr"
require "../control.cr"
require "../widget/*"

module Hedron
  class Combobox < Widget
    include Control

    @@box : Void*?

    @this : UI::Combobox*

    def initialize
      @this = UI.new_combobox
    end

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
      @@combobox = self

      new_proc = ->(combobox : UI::Combobox*, data : Void*) {
        callback = ::Box(Proc(Combobox, Nil)).unbox(data)
        callback.call(@@combobox.not_nil!)
      }

      UI.combobox_on_selected(to_unsafe, new_proc, boxed_data)
    end

    def selected : Int32
      return UI.combobox_selected(to_unsafe)
    end

    def selected=(index : Int32)
      UI.combobox_set_selected(to_unsafe, index)
    end

    def set_property(key : String, value : Any)
      gen_properties({"stretchy" => Bool, "selected" => Int32})
    end

    def to_unsafe
      return @this
    end
  end
end