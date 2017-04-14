class ClientServerModel < ServerModel    
 def messageBroadcast
  $socketUDP = UDPSocket.new
  $socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  $socketUDP.send(Config::BROADCAST_HELLO, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
  data, addr = $socketUDP.recvfrom(Config::SIZE_PACKAGE_SOCKET)
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
  while line = $socket.read(Config::SIZE_PACKAGE_DATA)
   puts line         
  end
  $socket.close 
 end
    
 def putsFile(binaryData, route)
  File.open(route, 'wb') {
   |f| f.write(Base64.decode64(binaryData))
  } 
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