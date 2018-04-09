require "../src/hedron/obj/*"

class ControlGallery
  # Note: @@mainwin is a class variable because
  # crystal does not support closures in C callbacks -- yet

  def initialize
    @@app = Hedron::Application.new
    app = @@app.not_nil!

    on_closing = ->(this : Hedron::Window) {
      this.destroy
      @@app.not_nil!.stop
      return false
    }

    should_quit = ->() {
      @@mainwin.not_nil!.destroy
      return true
    }

    open_clicked = ->(this : Hedron::MenuItem) {
      mainwin = @@mainwin.not_nil!
      filename = @@app.not_nil!.open_file(mainwin)

      if filename.nil?
        mainwin.error(title: "No file selected", description: "Don't be alarmed!")
      else
        mainwin.message(title: "File selected", description: filename)
      end
    }

    save_clicked = ->(this : Hedron::MenuItem) {
      mainwin = @@mainwin.not_nil!
      filename = @@app.not_nil!.save_file(mainwin)

      if filename.nil?
        mainwin.error(title: "No file selected", description: "Don't be alarmed!")
      else
        mainwin.message(title: "File selected (don't worry, it's still there)", description: filename)
      end
    }

    on_spinbox_changed = ->(this : Hedron::Spinbox) {
      value = this.value
      @@slider.not_nil!.value = value
      @@progressbar.not_nil!.value = value
    }

    on_slider_changed = ->(this : Hedron::Slider) {
      value = this.value
      @@spinbox.not_nil!.value = value
      @@progressbar.not_nil!.value = value
    }

    file_menu = Hedron::Menu.new("File")
    open = Hedron::MenuItem.new("Open", on_click: open_clicked)
    save = Hedron::MenuItem.new("Save", on_click: save_clicked)

    file_menu.add_all(open, save)
    file_menu.add_quit
    app.on_stop = should_quit

    edit_menu = Hedron::Menu.new("Edit")
    checkable = Hedron::MenuCheckItem.new("Checkable item")

    edit_menu.add(checkable)
    edit_menu.add_separator

    disabled = Hedron::MenuItem.new("Disabled Item")
    disabled.disable

    edit_menu.add(disabled)
    edit_menu.add_preferences

    help_menu = Hedron::Menu.new("Help")
    help = Hedron::MenuItem.new("Help")

    help_menu.add(help)
    help_menu.add_about

    @@mainwin = Hedron::Window.new("Hedron Control Gallery", {640, 480}, menubar: true)
    mainwin = @@mainwin.not_nil!
    mainwin.margined = true
    mainwin.on_close = on_closing

    box = Hedron::VerticalBox.new
    box.padded = true
    mainwin.child = box

    hbox = Hedron::HorizontalBox.new
    hbox.padded = true
    box.add(hbox, stretchy: true)

    group = Hedron::Group.new("Basic Controls")
    group.margined = true
    hbox.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    inner.add(Hedron::Button.new("Button"))
    inner.add(Hedron::Checkbox.new("Checkbox"))

    entry = Hedron::Entry.new
    entry.text = "Entry"
    inner.add(entry)
    inner.add(Hedron::Label.new("Label"))
    
    inner.add(Hedron::HorizontalSeparator.new)
    inner.add(Hedron::DatePicker.new)
    inner.add(Hedron::TimePicker.new)
    inner.add(Hedron::DateTimePicker.new)

    inner.add(Hedron::FontButton.new)
    inner.add(Hedron::ColorButton.new)

    inner2 = Hedron::VerticalBox.new
    inner2.padded = true
    hbox.add(inner2, stretchy: true)

    group = Hedron::Group.new("Numbers")
    group.margined = true
    inner2.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    @@spinbox = Hedron::Spinbox.new({0, 100})
    spinbox = @@spinbox.not_nil!
    spinbox.on_change = on_spinbox_changed
    inner.add(spinbox)

    @@slider = Hedron::Slider.new({0, 100})
    slider = @@slider.not_nil!
    slider.on_change = on_slider_changed
    inner.add(slider)

    @@progressbar = Hedron::ProgressBar.new
    progressbar = @@progressbar.not_nil!
    inner.add(progressbar)

    group = Hedron::Group.new("Lists")
    group.margined = true
    inner2.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    cbox = Hedron::Combobox.new
    cbox.add_all("Combobox Item 1", "Combobox Item 2", "Combobox Item 3")
    inner.add(cbox)

    ecbox = Hedron::EditableCombobox.new
    ecbox.add_all("Editable Item 1", "Editable Item 2", "Editable Item 3")
    inner.add(ecbox)

    rb = Hedron::RadioButtons.new
    rb.add_all("Radio Button 1", "Radio Button 2", "Radio Button 3")
    inner.add(rb, stretchy: true)

    tab = Hedron::Tab.new
    tab.add("Page 1", Hedron::HorizontalBox.new)
    tab.add("Page 2", Hedron::HorizontalBox.new)
    tab.add("Page 3", Hedron::HorizontalBox.new)
    inner2.add(tab, stretchy: true)

    mainwin.show

    app.start
    app.close
  end
end

ControlGallery.new
