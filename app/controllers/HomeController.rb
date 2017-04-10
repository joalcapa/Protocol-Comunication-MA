class HomeController
    
    def initialize(homeDao, homeView, config)
        @homeDao, @homeView, @running, @config = homeDao, homeView, true, config
        @thread = Thread.new{ run() }
    end
    
    def run
        while(@running)
            sleep(1);
        end
    end
    
    def threadPresent
        return @thread
    end
    
end