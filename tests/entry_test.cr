require "../src/hedron"

app = Hedron::App.main
window = Hedron::Window.new("Entry Test", Hedron::Size.new(640, 480))
entry = Hedron::Entry.new
# entry = Hedron::SearchEntry.new
# entry = Hedron::PasswordEntry.new



remainingKeystrokes = 5

entry.text = "Start typing! (You get five keystrokes) "
entry.on_changed do |entry|

    puts entry.text

    if remainingKeystrokes < 1
        entry.read_only = true
    else
        remainingKeystrokes -= 1
    end

end

window.child = entry
app.run(window)