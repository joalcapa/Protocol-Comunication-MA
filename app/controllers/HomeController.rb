class HomeController
    
    def initialize(homeDao, homeView)
        @homeDao, @homeView, @running = homeDao, homeView, true
        @thread = Thread.new{ run() }
    end
    
    def run()
        while(@running)
            puts "hola"
            sleep(1);
        end
    end
    
    def threadPresent()
        return @thread
    end
    
end