require 'tk'

class HomeView
    
    def initialize()
        config() 
        @thread = Thread.new{ run() }
    end
    
    def config() 
        if (ENV['TYPE_SERVICE'] == 'client') then
            @statusServer = false
        else
            @statusServer = true
        end
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