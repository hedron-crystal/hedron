module Hedron
  # Shorthand for creating bindings for C functions that take
  # functions as arguments, turning them into functions that take
  # Crystal blocks
  macro listener(name, data_type)
    @@{{name}}_box : Void*?

    def {{name}}(&block : {{data_type}} ->)
      boxed_data = ::Box.box(block)
      @@{{name}}_box = boxed_data

      new_proc = ->(this : UI::{{data_type}}*, data : Void*) {
        callback = ::Box(Proc({{data_type}}, Nil)).unbox(data)
        return callback.call({{data_type}}.new(Control.cast_ptr(this)))
      }

      UI.{{data_type.stringify.underscore.id}}_{{name}}(ptr, new_proc, boxed_data)
    end
  end
end