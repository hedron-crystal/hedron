module Hedron
  class Table < Control
    class Value
      @this : UI::TableValue*

      def initialize(color : Color)
        @this = UI.new_table_value_color(
          color.red / 255.0,
          color.green / 255.0,
          color.blue / 255.0,
          color.alpha / 255.0
        )
      end

      def initialize(image : Image)
        @this = UI.new_table_value_image(image.to_unsafe)
      end

      def initialize(int : Int32)
        @this = UI.new_table_value_int(int)
      end

      def initialize(string : String)
        @this = UI.new_table_value_string(string)
      end

      def initialize(@this); end

      def color : Color
        UI.table_value_color(to_unsafe, out r, out g, out b, out a)
        return Color.new(r, g, b, a)
      end

      def image : Image
        return Image.new(UI.table_value_image(to_unsafe))
      end

      def int : Int32
        return UI.table_value_int(to_unsafe)
      end

      def string : String
        return String.new(UI.table_value_string(to_unsafe))
      end

      def type : UI::TableValueType
        return UI.table_value_type(to_unsafe)
      end

      def to_unsafe
        return @this
      end
    end

    class Model
      @this : UI::TableModel*

      def initialize(handler : ModelHandler)
        @@handler = handler
        new_handler = UI::TableModelHandler.new

        new_handler.num_columns = ->(mh : UI::TableModelHandler*, model : UI::TableModel*) { @@handler.not_nil!.columns }
        new_handler.num_rows = ->(mh : UI::TableModelHandler*, model : UI::TableModel*) { @@handler.not_nil!.rows }
        new_handler.column_type = ->(mh : UI::TableModelHandler*, model : UI::TableModel*, i : Int32) { @@handler.not_nil!.column_type(i) }
        new_handler.cell_value = ->(mh : UI::TableModelHandler*, model : UI::TableModel*, x : Int32, y : Int32) {
          cell = @@handler.not_nil![x, y]
          return cell.nil? ? Pointer(UI::TableValue).null : cell.to_unsafe
        }
        new_handler.set_cell_value = ->(mh : UI::TableModelHandler*, model : UI::TableModel*, x : Int32, y : Int32, val : UI::TableValue*) { @@handler.not_nil!.[]=(x, y, Value.new(val)) }

        @this = UI.new_table_model(pointerof(new_handler))
      end

      def row_changed(index : Int32)
        UI.table_model_row_changed(to_unsafe, index)
      end

      def row_deleted(index : Int32)
        UI.table_model_row_deleted(to_unsafe, index)
      end

      def row_inserted(index : Int32)
        UI.table_model_row_inserted(to_unsafe, index)
      end

      def to_unsafe
        return @this
      end
    end

    module ModelHandler
      abstract def columns : Int32
      abstract def rows : Int32
      abstract def column_type(index : Int32) : UI::TableValueType
      abstract def [](x : Int32, y : Int32) : Value?
      abstract def []=(x : Int32, y : Int32, val : Value)
    end

    struct Params
      @model : Model
      @background_color_model : Int32

      def initialize(@model, @background_color_model); end

      def to_unsafe
        this = UI::TableParams.new
        this.model = @model.to_unsafe
        this.row_background_color_model_column = @background_color_model

        return pointerof(this)
      end
    end

    struct TextColumnParams
      @color_model : Int32

      def initialize(@color_model); end

      def to_unsafe
        this = UI::TableTextColumnOptionalParams.new
        this.color_model_column = @color_model
        
        return pointerof(this)
      end
    end

    struct TextColumn
      getter model : Int32
      getter editable_model : Int32
      getter params : UI::TableTextColumnOptionalParams*

      def initialize(@model, @editable_model, params : TextColumnParams? = nil)
        @params = params.nil? ? Pointer(UI::TableTextColumnOptionalParams).null : params.to_unsafe
      end
    end

    struct ImageColumn
      getter model : Int32

      def initialize(@model); end
    end

    struct CheckboxColumn
      getter model : Int32
      getter editable_model : Int32

      def initialize(@model, @editable_model); end
    end

    struct ProgressBarColumn
      getter model : Int32

      def initialize(@model); end
    end

    struct ButtonColumn
      getter model : Int32
      getter clickable_model : Int32

      def initialize(@model, @clickable_model); end
    end

    alias Column = TextColumn | ImageColumn | CheckboxColumn | ProgressBarColumn | ButtonColumn

    enum ColumnType
      Button
      Checkbox
      CheckboxText
      Image
      ImageText
      ProgressBar
      Text
    end
  end
end