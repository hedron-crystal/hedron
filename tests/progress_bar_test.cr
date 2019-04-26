require "../src/hedron"

app = Hedron::App.main
window = Hedron::Window.new("Progress Bar Test", Hedron::Size.new(640, 480))
container = Hedron::VerticalBox.new

upButton = Hedron::Button.new "+"
downButton = Hedron::Button.new "-"

bar = Hedron::ProgressBar.new

bar.value = 50


upButton.on_clicked do
    bar.value = bar.value() + 1
    puts bar.value
end

downButton.on_clicked do
    bar.value = bar.value() - 1
    puts bar.value
end

container.push bar
container.push upButton
container.push downButton

window.child = container
app.run(window)