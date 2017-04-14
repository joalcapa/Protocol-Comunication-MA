class Config
 TYPE_SERVICE_CLIENT = 'CLIENT'
 TYPE_OPERATION_CLIENT_BROADCAST = 'BROADCAST'
 TYPE_OPERATION_CLIENT_NONE = 'NONE'
 TYPE_SERVICE_SERVER = 'SERVER'
    
 BROADCAST_HOST = ENV['BROADCAST_HOST'] || '255.255.255.255'
 BROADCAST_PORT = ENV['BROADCAST_PORT'] || '3000'
 BROADCAST_HELLO = ENV['BROADCAST_HELLO'] || 'HELLO SERVER MA'
    
 SERVER_HOST = ENV['SERVER_HOST'] || '0.0.0.0'
 SERVER_PORT = ENV['SERVER-PORT'] || '3000'
 SERVER_HELLO = ENV['SERVER-HELLO'] || 'HELLO CLIENT MA'

 CONFIG_NULL = 'NULL'
    
 def initialize
  @typeService = ENV['TYPE_SERVICE'] || TYPE_SERVICE_CLIENT
  @typeOperationClient = ENV['TYPE_OPERATION_CLIENT'] || TYPE_OPERATION_CLIENT_BROADCAST
  @mutex=Mutex.new
 end
    
 def getTypeService
  @mutex.synchronize do
   $typeService = @typeService
  end
  return $typeService
 end
    
 def setTypeService(typeService)
  @mutex.synchronize do
   @typeService = typeService
  end
 end
    
 def getTypeOperationClient
  return @typeOperationClient
 end   
end