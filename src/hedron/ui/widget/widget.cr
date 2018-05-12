require "../../parser/any.cr"
require "../control/control.cr"

module Hedron
  alias MLArgs = Hash(String, Any)

  # A widget is the main class that all UI elements in
  # Hedron are derived from.
  abstract class Widget
    property parent : Widget?

    # Markup language integration functions

    # Allows for a widget to be initialized in a .hdml file.
    # If you wish to use your own widget in the markup language,
    # you must override this function.
    # 
    # This version of `self.init_markup` does not take arguments, so in your .hdml
    # file, you are not allowed to put in initialization arguments. For example, this
    # HDML code will raise an error:
    # ```
    # Foo {
    #   @bar: true;
    #   @baz: true;
    # }
    # You can access your arguments like so:
    # ```crystal
    # args["bar"].as(Bool) # All results from MLArgs are Hedron::Any,
    #                      # so you may need to cast to a more specific type
    #                      # before using.
    # ```
    def self.init_markup : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    # Allows for a widget to be initialized in a .hdml file.
    # If you wish to use your own widget in the markup language,
    # you must override this function.
    # 
    # This version of `self.init_markup` takes arguments, so in your .hdml
    # file, you must provide all of your initialization arguments. So, if
    # your widget `Foo` has initialization arguments `bar` and `baz`, you must
    # write both of them in:
    # ```
    # Foo {
    #   @bar: true;
    #   @baz: true;
    # }
    # You can access your arguments like so:
    # ```crystal
    # args["bar"].as(Bool) # All results from MLArgs are Hedron::Any,
    #                      # so you may need to cast to a more specific type
    #                      # before using.
    # ```
    def self.init_markup(args : MLArgs) : Widget
      raise ParseError.new("Widget initialization has not been implemented")
    end

    # Returns the name of a widget to be used in .hdml files.
    # For example, if `Foo` returns `MyFoo` in this function, you can
    # use it in a .hdml file like so:
    # ```
    # MyFoo {
    #   // Insert code here
    # }
    # ```
    def self.widget_name : String
      return self.name.split("::")[-1]
    end

    # Helper macro used to cast attributes from HDML,
    # takes a Hash(String, Class) as an argument.
    # Used in the set_attribute() function:
    # ```crystal
    # def set_attribute(key : String, value : Any)
    #   gen_attributes({
    #     "foo" => Int32
    #   })
    # end
    # ```
    macro gen_attributes(attrs)
      {% begin %}
        case key
        {% for key, val in attrs %}
          when {{key}}
            self.{{key.id}} = value.as({{val}})
        {% end %}
          else
            raise ParseError.new("No such attribute: #{key}")
        end
      {% end %}
    end

    # Allows for HDML to set an attribute. In your `set_attribute` function,
    # you must call the `gen_attributes` function, as well as provide a hash
    # with attribute names and their corresponding classes:
    # ```crystal
    # def set_attribute(key : String, value : Any)
    #   gen_attributes({
    #     "foo" => Int32
    #   })
    # end
    # ```
    # The list of classes supported can be found in Hedron::Any.
    def set_attribute(key : String, value : Any)
      raise ParseError.new("Widget does not have any attributes")
    end

    def parent?(widget : Widget) : Bool
      return @parent == widget
    end

    abstract def display : Control
  end
end
