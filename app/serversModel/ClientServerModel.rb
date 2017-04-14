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
  @imagen = ''
  @running = true
  $socket = TCPSocket.new @addrServer, @portServer
  while @running
   sendPackages()
  end
  putsFile(@imagen, 'imagenn.png')
  $socket.close
 end
    
 def sendPackages
  data, addr = $socket.recvfrom(Config::SIZE_PACKAGE_DATA)
  if(data == Config::CLOSED_COMUNICATION) then
   @running = false
  else
   @imagen = @imagen + data
  end
 end
       
 def putsFile(binaryData, route)
  File.open(route, 'wb') {
      |f| f.write(binaryData)
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