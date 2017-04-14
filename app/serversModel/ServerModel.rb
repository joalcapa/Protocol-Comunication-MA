class ServerModel
 def initialize(config, typeService)
  @config = config
  @typeService = typeService
  @thread = nil
  initResource()
  runRunner()
 end
    
 def initResource
 end
    
 def run
     puts 'aqui'
  while @running
   runner()
   sleep(1)
  end
 end
    
 def runner
 end
    
 def runRunner
  if @typeService == @config.getTypeService
   @running = true
   @thread = Thread.new{ run() }
  end
 end
    
 def stopRunner
 end
        
 def killServer
  if @typeService != @config.getTypeService
   @running = false
   stopRunner()
   @thread = nil
  else
    runRunner() if @thread.nil?
  end
 end      
end