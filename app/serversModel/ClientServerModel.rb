class ClientServerModel < ServerModel    
 def messageBroadcast
  $socketUDP = UDPSocket.new
  $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  $socketUDP.send(Config::BROADCAST_HELLO, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
  data, addr = $socketUDP.recvfrom(1024)
  arrayData = data.split(":")
  if arrayData.length == 2
   if arrayData[0] == Config::SERVER_HELLO
    @addrServer = addr[3]
    @portServer = arrayData[1]
    @config.setTypeOperationClient(Config::TYPE_OPERATION_CLIENT_CONVERSATION)
   end
  end
  $socketUDP.close
 end
    
 def converse
  $socket = TCPSocket.new @addrServer, @portServer
  while line = $socket.read(1024)
   puts line         
  end
  $socket.close 
 end

 def runner
  case @config.getTypeService
  when Config::TYPE_SERVICE_CLIENT
   case @config.getTypeOperationClient
   when Config::TYPE_OPERATION_CLIENT_CONVERSATION
    converse()
   when Config::TYPE_OPERATION_CLIENT_BROADCAST
    messageBroadcast()
   end
  end
 end
end