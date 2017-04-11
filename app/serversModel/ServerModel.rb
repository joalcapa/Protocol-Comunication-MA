class ServerModel
    
    def initialize(config, typeService)
        @config = config
        @typeService = typeService
        @thread = nil
        runRunner()
    end
    
    def run
        while(@running)
            runner()
            sleep(1);
        end
    end
    
    def runner
    end
    
    def runRunner()
        if(@typeService == @config.getTypeService) then
            @running = true
            @thread = Thread.new{ run() }
        end
    end
        
    def killServer
        if(@typeService != @config.getTypeService) then
            @running = false
            @thread = nil
        else
            if(@thread == nil) then
                runRunner()
            end
        end
    end
end