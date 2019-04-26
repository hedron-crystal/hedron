require "../src/hedron"

app = Hedron::App.main
window = Hedron::Window.new("Button Test", Hedron::Size.new(640, 480))
button = Hedron::Button.new "Click Me!"

button.on_clicked do |button|
    puts "Clicked!"
end

window.child = button
app.run(window)