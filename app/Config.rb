class Config
 TYPE_SERVICE_CLIENT = 'CLIENT'
 TYPE_OPERATION_CLIENT_BROADCAST = 'BROADCAST'
 TYPE_OPERATION_CLIENT_CONVERSATION = 'CONVERSATION'
 TYPE_OPERATION_CLIENT_NONE = 'NONE'
 TYPE_SERVICE_SERVER = 'SERVER'
 SERVER_FOUND = 'SERVER FOUND'
 DISCONNECTED_FROM_SERVER = 'DISCONNECTED FROM SERVER'
 DOWNLOADING_RESOURCE = 'DOWNLOADING RESOURCE'
    
 SEARCHING_SERVER = 'SEARCHING SERVER'
 MESSAGE_SERVER = 'SERVICE SERVER'
    
 BROADCAST_HOST = ENV['BROADCAST_HOST'] || '255.255.255.255'
 BROADCAST_PORT = ENV['BROADCAST_PORT'] || '3000'
 BROADCAST_HELLO = ENV['BROADCAST_HELLO'] || 'HELLO SERVER MA'
    
 SERVER_HOST = ENV['SERVER_HOST'] || '0.0.0.0'
 SERVER_PORT = ENV['SERVER-PORT'] || '3000'
 SERVER_PORT_MA = ENV['SERVER_PORT_MA'] || '4500'
 SERVER_HELLO = ENV['SERVER_HELLO'] || 'HELLO CLIENT MA'
 SERVER_HELLO_PORT = ENV['SERVER_HELLO_PORT'] || 'HELLO CLIENT MA:4500'
    
 MACHINE_IP = (Socket.ip_address_list.detect{|intf| intf.ipv4_private?}).ip_address
 
 ROUTE_RESOURCE = ENV['ROUTE_RESOURCE'] || 'assets/resource.gif'
 SIZE_PACKAGE_DATA = ENV['SIZE_PACKAGE_DATA'] || 1024
 SIZE_PACKAGE_SOCKET = ENV['SIZE_PACKAGE_SOCKET'] || 2048
 CLOSED_COMUNICATION = ENV['CLOSED_COMUNICATION'] || 'CLOSED COMUNICATION'

 CONFIG_NULL = 'NULL'
    
 def initialize
  @typeService = ENV['TYPE_SERVICE'] || TYPE_SERVICE_CLIENT
  @typeOperationClient = TYPE_OPERATION_CLIENT_BROADCAST
  @timeNormal = ENV['TIME_NORMAL_APPLICATION'] || 1
  @timeClosed = ENV['TIME_THREAD_WAITTING_CLOSED'] || 2
  @timeSend = ENV['TIME_THREAD_SERVER_SEND'] || 1
  @arrayData = bytesData(Config::ROUTE_RESOURCE)
  @mutex=Mutex.new
 end
    
 def timeNormal
  return @timeNormal.to_i
 end
    
 def timeClosed
  return @timeClosed.to_i
 end
    
 def timeSend
  return @timeSend.to_i
 end
    
 def getTypeService
  return @typeService
 end
    
 def getTypeOperationClient
  return @typeOperationClient
 end
    
 def getSegmentArrayData(start, length)
  return @arrayData[start,length]
 end
    
 def sizeArrayData
  return @arrayData.length
 end
    
 def setTypeOperationClient(typeOperationClient)
   @typeOperationClient = typeOperationClient
 end
    
 def bytesData(route)
  f = File.binread route
  f.unpack('C*')
  return f
 end
    
 def mutex
  return @mutex
 end
end