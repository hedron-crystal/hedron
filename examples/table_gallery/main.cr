require "../../src/hedron.cr"

class TableGallery < Hedron::Application
  @images = [] of Hedron::Image
  @row_9_text = ""
  @yellow_row = -1
  @states = [] of Int32

  def on_closing(this)
    this.destroy
    self.stop
    return false
  end

  def should_quit
    @window.not_nil!.destroy
    return true
  end

  def draw
    self.on_stop = ->should_quit

    @window = Hedron::Window.new("Table Gallery", {640, 480}, menubar: true)
    @window.not_nil!.on_close = ->on_closing(Hedron::Window)

    @images.push(Hedron::Image.new(16, 16))
    @images[0].push_png("./images/andlabs_16x16test_24june2016.png")
    @images[0].push_png("./images/andlabs_32x32test_24june2016.png")

    @images.push(Hedron::Image.new(16, 16))
    @images[1].push_png("./images/tango-icon-theme-0.8.90_16x16_x-office-spreadsheet.png")
    @images[1].push_png("./images/tango-icon-theme-0.8.90_32x32_x-office-spreadsheet.png")

    @row_9_text = "Part"

    @states = Array(Int32).new(15) { 0 }

    page = Hedron::VerticalBox.new
    @model = Hedron::Table::Model.new(self)

    params = Hedron::Table::Params.new(@model.not_nil!, 3)

    table = Hedron::Table.new(params)
    table.stretchy = true
    page.push(table)

    table.push_text_column("Column 1", Hedron::Table::TextColumn.new(0, -1))
    text_params = Hedron::Table::TextColumnParams.new(4)
    table.push_image_text_column(
      "Column 2",
      Hedron::Table::ImageColumn.new(5),
      Hedron::Table::TextColumn.new(1, -1, text_params)
    )
    table.push_text_column("Editable", Hedron::Table::TextColumn.new(2, -2))

    table.push_checkbox_column("Checkboxes", Hedron::Table::CheckboxColumn.new(7, -2))
    table.push_button_column("Buttons", Hedron::Table::ButtonColumn.new(8, -2))
    table.push_progress_bar_column("Progress Bar", Hedron::Table::ProgressBarColumn.new(6))

    @window.not_nil!.child = page
    @window.not_nil!.show
  end
end

class TableGallery
  include Hedron::Table::ModelHandler

  def columns
    return 9
  end

  def rows
    return 15
  end

  def column_type(column)
    case column
      when 3, 4 then UI::TableValueType::Color
      when 5 then UI::TableValueType::Image
      when 7, 8 then UI::TableValueType::Int
      else UI::TableValueType::String
    end
  end

  def [](row, column)
    return case column
      when 0
        Hedron::Table::Value.new("Row #{row}")
      when 1
        Hedron::Table::Value.new("Part")
      when 2
        Hedron::Table::Value.new(row == 9 ? @row_9_text : "Part")
      when 3
        case row
          when @yellow_row
            Hedron::Table::Value.new(Hedron::Color.new(255_u8, 255_u8, 0_u8, 255_u8))
          when 3
            Hedron::Table::Value.new(Hedron::Color.new(255_u8, 0_u8, 0_u8, 255_u8))
          when 11
            Hedron::Table::Value.new(Hedron::Color.new(0_u8, 127_u8, 255_u8, 0_u8))
        end
      when 4
        row.odd? ? Hedron::Table::Value.new(Hedron::Color.new(127_u8, 0_u8, 191_u8, 255_u8)) : nil
      when 5
        Hedron::Table::Value.new(row < 8 ? @images[0] : @images[1])
      when 6
        Hedron::Table::Value.new("Make Yellow")
      when 7
        Hedron::Table::Value.new(@states[row])
      when 8
        Hedron::Table::Value.new(case row
          when 0 then 0
          when 13 then 100
          when 14 then -1
          else 50
        end)
    end
  end

  def []=(row, column, value)
    case column
      when 2
        @row_9_text = value.string if row == 9
      when 6
        prev_yellow_row = @yellow_row
        @yellow_row = row

        @model.not_nil!.row_changed(prev_yellow_row != -1 ? prev_yellow_row : @yellow_row)
      when 7
        @states[row] = value.int
    end
  end
end

gallery = TableGallery.new
gallery.start
gallery.close
