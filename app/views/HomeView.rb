require 'tk'

class HomeView
    
    def initialize()
        @statusServer = false
        @thread = Thread.new{ run() }
    end
    
    def run()
        root = TkRoot.new { title "ProtocolRuby" }
        TkLabel.new(root) do
            text 'ProtocolRuby'
            pack { padx 15 ; pady 15; side 'left' }
        end
        Tk.mainloop
    end
    
    def threadPresent()
        return @thread
    end
    
    def statusServer()
        return @statusServer
    end
    
end