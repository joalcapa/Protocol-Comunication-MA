class ServerModel
 def initialize(config)
  @config = config
  @thread = nil
  initResource()
  runRunner()
 end
    
 def initResource
 end
    
 def run
  while @running
   runner()
   sleep(@config.timeNormal)
  end
 end
    
 def runner
 end
    
 def runRunner
   @running = true
   @thread = Thread.new{ run() }
 end
    
 def stopRunner
 end
        
 def killServer
   @running = false
   stopRunner()
   @thread = nil
 end      
end