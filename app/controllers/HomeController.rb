class HomeController
    
    def initialize(homeModel, homeView)
        @homeModel, @homeView, @running = homeModel, homeView, true
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