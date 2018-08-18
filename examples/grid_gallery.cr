require "../src/hedron.cr"

class GridGallery < Hedron::Application
  @window : Hedron::Window?

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

    @window = Hedron::Window.new("Grid Gallery", {640, 480}, menubar: true)
    @window.not_nil!.on_close = ->on_closing(Hedron::Window)

    grid = Hedron::Grid.new
    grid.padded = true

    cell_info = Hedron::GridCell.new(
      size: {1, 1},
      expand: {false, false},
      align_x: :fill,
      align_y: :fill
    )

    grid.push(Hedron::Label.new("Name"), {0, 0}, cell_info)
    grid.push(Hedron::Label.new("Surname"), {0, 1}, cell_info)
    grid.push(Hedron::Label.new("Age"), {0, 2}, cell_info)

    name = Hedron::Entry.new
    name.text = "Qwerp"
    grid.push(name, {1, 0}, cell_info)

    surname = Hedron::Entry.new
    surname.text = "Derp"
    grid.push(surname, {1, 1}, cell_info)

    age = Hedron::Slider.new({0, 100})
    age.value = 40
    grid.push(age, {1, 2}, cell_info)

    @window.not_nil!.child = grid
    @window.not_nil!.show
  end
end

gallery = GridGallery.new
gallery.start
gallery.close
