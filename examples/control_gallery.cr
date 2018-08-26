require "../src/hedron.cr"

class ControlGallery < Hedron::Application
  @mainwin : Hedron::Window?

  @progressbar : Hedron::ProgressBar?
  @slider : Hedron::Slider?
  @spinbox : Hedron::Spinbox?

  def on_closing(this)
    this.destroy
    self.stop
    return false
  end

  def should_quit
    @mainwin.not_nil!.destroy
    return true
  end

  def open_clicked(this)
    mainwin = @mainwin.not_nil!
    filename = open_file(mainwin)

    if filename.nil?
      mainwin.error(title: "No file selected", description: "Don't be alarmed!")
    else
      mainwin.message(title: "File selected", description: filename)
    end
  end

  def save_clicked(this)
    mainwin = @mainwin.not_nil!
    filename = save_file(mainwin)

    if filename.nil?
      mainwin.error(title: "No file selected", description: "Don't be alarmed!")
    else
      mainwin.message(title: "File selected (don't worry, it's still there)", description: filename)
    end
  end

  def on_spinbox_changed(this)
    value = this.value
    @slider.not_nil!.value = value
    @progressbar.not_nil!.value = value
  end

  def on_slider_changed(this)
    value = this.value
    @spinbox.not_nil!.value = value
    @progressbar.not_nil!.value = value
  end

  def draw
    file_menu = Hedron::Menu.new("File")
    open = Hedron::MenuItem.new(file_menu, "Open")
    save = Hedron::MenuItem.new(file_menu, "Save")

    file_menu.push(:quit)
    self.on_stop = ->should_quit

    edit_menu = Hedron::Menu.new("Edit")
    checkable = Hedron::MenuCheckItem.new(edit_menu, "Checkable item")

    edit_menu.push(:separator)

    disabled = Hedron::MenuItem.new(edit_menu, "Disabled Item")
    disabled.disable

    edit_menu.push(:preferences)

    help_menu = Hedron::Menu.new("Help")
    help = Hedron::MenuItem.new(help_menu, "Help")

    help_menu.push(:about)

    @mainwin = Hedron::Window.new("Hedron Control Gallery", {640, 480}, menubar: true)
    mainwin = @mainwin.not_nil!
    mainwin.margined = true
    mainwin.on_close = ->on_closing(Hedron::Window)

    box = Hedron::VerticalBox.new
    box.padded = true
    mainwin.child = box

    hbox = Hedron::HorizontalBox.new
    hbox.padded = true
    hbox.stretchy = true
    box.push(hbox)

    group = Hedron::Group.new("Basic Controls")
    group.margined = true
    hbox.push(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    inner.push(
      Hedron::Button.new("Button"),
      Hedron::Checkbox.new("Checkbox")
    )

    entry = Hedron::Entry.new
    entry.text = "Entry"

    inner.push(
      entry,
      Hedron::Label.new("Label"),
      Hedron::HorizontalSeparator.new,
      Hedron::DatePicker.new,
      Hedron::TimePicker.new,
      Hedron::DateTimePicker.new,
      Hedron::FontButton.new,
      Hedron::ColorButton.new
    )

    inner2 = Hedron::VerticalBox.new
    inner2.padded = true
    inner2.stretchy = true
    hbox.push(inner2)

    group = Hedron::Group.new("Numbers")
    group.margined = true
    inner2.push(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    @spinbox = Hedron::Spinbox.new({0, 100})
    spinbox = @spinbox.not_nil!
    spinbox.on_change = ->on_spinbox_changed(Hedron::Spinbox)
    inner.push(spinbox)

    @slider = Hedron::Slider.new({0, 100})
    slider = @slider.not_nil!
    slider.on_change = ->on_slider_changed(Hedron::Slider)
    inner.push(slider)

    @progressbar = Hedron::ProgressBar.new
    progressbar = @progressbar.not_nil!
    inner.push(progressbar)

    group = Hedron::Group.new("Lists")
    group.margined = true
    inner2.push(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    cbox = Hedron::Combobox.new
    cbox.choices = ["Combobox Item 1", "Combobox Item 2", "Combobox Item 3"]
    inner.push(cbox)

    ecbox = Hedron::EditableCombobox.new
    ecbox.choices = ["Editable Item 1", "Editable Item 2", "Editable Item 3"]
    inner.push(ecbox)

    rb = Hedron::RadioButtons.new
    rb.choices = ["Radio Button 1", "Radio Button 2", "Radio Button 3"]
    rb.stretchy = true
    inner.push(rb)

    tab = Hedron::Tab.new
    tab["Page 1"] = Hedron::HorizontalBox.new
    tab["Page 2"] = Hedron::HorizontalBox.new
    tab["Page 3"] = Hedron::HorizontalBox.new
    tab.stretchy = true
    inner2.push(tab)

    mainwin.show
  end
end

gallery = ControlGallery.new
gallery.start
gallery.close
