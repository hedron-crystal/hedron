require "../src/hedron"

counter = 5

app = Hedron::App.main
window = Hedron::Window.new("Hello, World!", Hedron::Size.new(640, 480))
label = Hedron::Label.new("Close #{counter} more times to exit.")

window.on_closing do
  puts counter
  
  if counter.zero?
    true
  else
    counter -= 1
    label.text = "Close #{counter} more times to exit."
    false
  end
end

window.child = label
app.run(window)
