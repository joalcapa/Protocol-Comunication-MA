class HomeDao
    
    def initialize(config)
        @config = config
        @running = true
        @thread = Thread.new{ run() }
    end
        
    def messageBroadcast
        $socketUDP = UDPSocket.new
        $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
        UDPSock.send(Config::DATA_BROADCAST, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
        #UDPSock.close
    end
        
    def run
        while(@running)
            if (@config.getTypeService == Config::TYPE_SERVICE_CLIENT  &&
                @config.getTypeOperationClient == Config::TYPE_OPERATION_CLIENT_BROADCAST)
            then
                messageBroadcast()
            end
            sleep(1);
        end
    end
    
end