class HomeDao
    
    def initialize()
         config()
    end
        
    def config() 
        if (ENV['TYPE_SERVICE'] == 'client') then
            @statusServer = false
        else
            @statusServer = true
        end
    end
    
end