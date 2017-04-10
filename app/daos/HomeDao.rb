class HomeDao
    
    def initialize(config)
        @config = config
        @running = true
        @clientModel = ClientModel.new
        @serverModel = ServerModel.new
        @thread = Thread.new{ run() }
    end
        
    def run
        while(@running)
            case @config.getTypeService
                when Config::TYPE_SERVICE_CLIENT
                    case @config.getTypeOperationClient
                         when Config::TYPE_OPERATION_CLIENT_BROADCAST
                             @clientModel.messageBroadcast()
                    end
                when Config::TYPE_SERVICE_SERVER
            end
            sleep(1);
        end
    end
    
end