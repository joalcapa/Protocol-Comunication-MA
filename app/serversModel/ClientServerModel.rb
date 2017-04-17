class ClientServerModel < ServerModel 
 def initResource
  @isActiveResource = false
  @config.mutex().lock
   @status = Config::SEARCHING_SERVER
  @config.mutex().unlock
 end
    
 def getStatus
  return @status
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
    @config.mutex().lock
     @status = Config::SERVER_FOUND
    @config.mutex().unlock
    @resource = ''
    @runningSocket = true
    $socket = TCPSocket.new @addrServer, @portServer
   end
  end
  $socketUDP.close
 end
    
 def converse
  if @runningSocket
   receivePackages()
  else 
   $socket.close
   @running = false
   @config.mutex().lock
    @isActiveResource = true
   @config.mutex().unlock
  end
 end
    
 def receivePackages
  data, addr = $socket.recvfrom(Config::SIZE_PACKAGE_DATA)
  if(data == Config::CLOSED_COMUNICATION) then
   @runningSocket = false
   @config.mutex().lock
    @status = Config::DISCONNECTED_FROM_SERVER
   @config.mutex().unlock
  else
   @config.mutex().lock
    @status = Config::DOWNLOADING_RESOURCE
   @config.mutex().unlock
   @resource = @resource + data
  end
 end

 def runner
  case @config.getTypeOperationClient
  when Config::TYPE_OPERATION_CLIENT_CONVERSATION
   converse()
  when Config::TYPE_OPERATION_CLIENT_BROADCAST
   messageBroadcast()
  end
 end
     
 def isActiveResource
  return @isActiveResource
 end
     
 def dataResource
  return @resource
 end
end