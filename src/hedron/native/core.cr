module Hedron
  macro listener(name, data_type = Nil)
    def {{name}}(&block : {{data_type}} -> {{return_type}})
      boxed_data = ::Box.box(block)
      @@{{name}}_box = boxed_data

      new_proc = ->(this : UI::{{data_type}}*, data : Void*) {
        callback = ::Box(Proc({{data_type}}, {{return_type}})).unbox(data)
        return callback.call({{data_type}}.new(this))
      }

      UI.on_{{name}}(self.to_unsafe, new_proc, boxed_data)
    end
  end
end