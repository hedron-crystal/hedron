require "../src/hedron"

app = Hedron::App.main
window = Hedron::Window.new "Progress Bar Test", Hedron::Size.new(640, 480)
container = Hedron::VerticalBox.new
label = Hedron::Label.new "This is a Label."

window.on_closing do

    puts "Window will close."

    app.shutdown # Shuts down the application

    true # Tells Crystal that this block returns a Bool

end


# TODO: For some reason this is not being called (ubuntu)
app.on_should_shutdown do

    puts "Application will quit."

    true # Tells Crystal that this block returns a Bool

end

# Stylization
window.margined = true
container.padded = true

# Assembles the hierarchy
container.push label
window.child = container

# Starts up the app, and shows the window
app.run window