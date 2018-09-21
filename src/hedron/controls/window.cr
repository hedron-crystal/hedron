module Hedron
  class Window < Control
    Hedron.listener on_position_changed, Window
    Hedron.listener on_content_size_changed, Window
    
    
  end
end