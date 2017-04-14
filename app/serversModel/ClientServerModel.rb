class ClientServerModel < ServerModel    
 def messageBroadcast
  puts 'Cliente live'
  $socketUDP = UDPSocket.new
  $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  $socketUDP.send(Config::BROADCAST_HELLO, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
  $socketUDP.close
 end

 def runner
  case @config.getTypeService
  when Config::TYPE_SERVICE_CLIENT
   case @config.getTypeOperationClient
   when Config::TYPE_OPERATION_CLIENT_BROADCAST
    messageBroadcast()
   end
  end
 end
end