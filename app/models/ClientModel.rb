class ClientModel
    
    def initialize   
    end
    
    def messageBroadcast
        $socketUDP = UDPSocket.new
        $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
        UDPSock.send(Config::DATA_BROADCAST, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
        #UDPSock.close
    end
    
end