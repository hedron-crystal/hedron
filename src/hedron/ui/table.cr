require "./table_objects.cr"
require "../bindings.cr"
require "../widget/control.cr"

module Hedron
  class Table < Control
    def initialize(params : Params)
      @this = ui_control(UI.new_table(params.to_unsafe))
    end

    def push_button_column(name : String, button_column : ButtonColumn)
      UI.table_append_button_column(
        to_unsafe, name,
        button_column.model, button_column.clickable_model
      )
    end

    def push_checkbox_column(name : String, checkbox_column : CheckboxColumn)
      UI.table_append_checkbox_column(
        to_unsafe, name,
        checkbox_column.model, checkbox_column.editable_model
      )
    end
    
    def push_checkbox_text_column(name : String, checkbox_column : CheckboxColumn, text_column : TextColumn)
      UI.table_append_checkbox_text_column(
        to_unsafe, name,
        checkbox_column.model, checkbox_column.editable_model,
        text_column.model, text_column.editable_model, text_column.params
      )
    end

    def push_image_column(name : String, image_column : ImageColumn)
      UI.table_append_image_column(to_unsafe, name, image_column.model)
    end

    def push_image_text_column(name : String, image_column : ImageColumn, text_column : TextColumn)
      UI.table_append_image_text_column(
        to_unsafe, name,
        image_column.model,
        text_column.model, text_column.editable_model, text_column.params
        )
    end

    def push_progress_bar_column(name : String, progress_bar_column : ProgressBarColumn)
      UI.table_append_progress_bar_column(to_unsafe, name, progress_bar_column.model)
    end

    def push_text_column(name : String, text_column : TextColumn)
      UI.table_append_text_column(
        to_unsafe, name,
        text_column.model, text_column.editable_model, text_column.params
      )
    end

    def to_unsafe
      return @this.as(UI::Table*)
    end
  end
end