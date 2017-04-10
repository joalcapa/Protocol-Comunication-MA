class HomeDao
    
    def initialize()
        config()
    end
        
    def config() 
        if (ENV['TYPE_SERVICE'] == 'client') then
            @statusServer = false
            @socketUDP = UDPSocket.new
            @socketUDP.bind(ENV['CLIENT_HOST'], ENV['CLIENT_PORT'])
            messageBroadcast()
        else
            @statusServer = true
            messageBroadcast()
        end
    end
        
    def messageBroadcast()
        
    end
    
end