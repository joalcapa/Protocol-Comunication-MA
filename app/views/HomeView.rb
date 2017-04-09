require 'tk'

class HomeView
    
    def initialize()
        root = TkRoot.new { title "ProtocolRuby" }
        TkLabel.new(root) do
            text 'ProtocolRuby'
            pack { padx 15 ; pady 15; side 'left' }
        end
        Tk.mainloop
    end
    
end