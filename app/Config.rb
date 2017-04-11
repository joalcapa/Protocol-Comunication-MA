class Config
    
    TYPE_SERVICE_CLIENT = 'CLIENT'
    TYPE_OPERATION_CLIENT_BROADCAST = 'BROADCAST'
    TYPE_OPERATION_CLIENT_NONE = 'NONE'
    
    TYPE_SERVICE_SERVER = 'SERVER'
    
    BROADCAST_HOST = '255.255.255.255'
    BROADCAST_PORT = 3000
    DATA_BROADCAST = 'EE-34'
    
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