class ClientServerModel < ServerModel
    
    def messageBroadcast
        $socketUDP = UDPSocket.new
        $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
        UDPSock.send(Config::DATA_BROADCAST, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
        #UDPSock.close
    end
    
    def runner
        case @config.getTypeService
            when Config::TYPE_SERVICE_CLIENT
                case @config.getTypeOperationClient
                    when Config::TYPE_OPERATION_CLIENT_BROADCAST
                        @clientModel.messageBroadcast()
                end
        end
    end
    
end