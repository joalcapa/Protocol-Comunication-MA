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
            if (@config.getTypeService == Config::TYPE_SERVICE_CLIENT  &&
                @config.getTypeOperationClient == Config::TYPE_OPERATION_CLIENT_BROADCAST)
            then
                @clientModel.messageBroadcast()
            end
            sleep(1);
        end
    end
    
end