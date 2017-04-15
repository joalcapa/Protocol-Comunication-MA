class ClientServerModel < ServerModel 
 def initResource
  @isActiveResource = false
  @mutex=Mutex.new
  @status = Config::SEARCHING_SERVER
 end
    
 def getStatus
  @mutex.synchronize do
   $status = @status
  end
  return $status
 end
    
 def setStatus(status)
  @mutex.synchronize do
   @status = status
  end
 end
 
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
    #setStatus(Config::SERVER_FOUND)
   end
  end
  $socketUDP.close
 end
    
 def converse
  @resource = ''
  @runningSocket = true
  $socket = TCPSocket.new @addrServer, @portServer
  while @runningSocket
   sendPackages()
   #setStatus(Config::DOWNLOADING_RESOURCE)
  end
  $socket.close
  @running =false
  @isActiveResource = true
  #setStatus(Config::DISCONNECTED_FROM_SERVER)
 end
    
 def sendPackages
  data, addr = $socket.recvfrom(Config::SIZE_PACKAGE_DATA)
  if(data == Config::CLOSED_COMUNICATION) then
   @runningSocket = false
  else
   @resource = @resource + data
  end
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
     
 def isActiveResource
  return @isActiveResource
 end
     
 def dataResource
  return @resource
 end
end