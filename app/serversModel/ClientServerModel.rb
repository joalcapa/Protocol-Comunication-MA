class ClientServerModel < ServerModel 
 def initResource
  @config.mutex().lock
   @timeSearchServer = 0
   @isActiveResource = false
   @status = Config::SEARCHING_SERVER
  @config.mutex().unlock
 end
    
 def getStatus
  return @status
 end
 
 def messageBroadcast
  @socketUDP = UDPSocket.new
  @socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  @socketUDP.send(Config::BROADCAST_HELLO, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
  begin
   data, addr = @socketUDP.recvfrom(Config::SIZE_PACKAGE_SOCKET)
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
     @socket = TCPSocket.new @addrServer, @portServer
    end
   end
   @socketUDP.close
  rescue
   @timeSearchServer = 0
  end 
 end
    
 def converse
  @config.mutex().lock
   data, addr = @socket.recvfrom(Config::SIZE_PACKAGE_DATA)
    if(data == Config::CLOSED_COMUNICATION) then
     @status = Config::DISCONNECTED_FROM_SERVER
     @socket.close
     @running = false
     @isActiveResource = true
    else
     @status = Config::DOWNLOADING_RESOURCE
     @resource = @resource + data
    end
  @config.mutex().unlock
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
     
 def timeSearchServer
  if(@timeSearchServer < 7)
   @timeSearchServer = @timeSearchServer + 1
  else
   if (@status == Config::SEARCHING_SERVER)
    @socketUDP.close
   end
  end
 end
end