class HomeController
 def initialize(homeDao, homeView, config)
  @homeDao, @homeView, @running, @config = homeDao, homeView, true, config
  @thread = Thread.new{ run() }
 end
    
 def run
  while @running
   if @homeView.getEvent
    @homeDao.killServer
    @homeView.setEvent(false)
   end
   @homeView.asignDataImage(@homeDao.dataResource()) if @homeDao.isClientActiveResource
   @homeView.status(@homeDao.status)
   @running = @homeView.getRunning
   sleep(1);
  end
  @config.setTypeService(Config::CONFIG_NULL)
  @homeDao.killServer
 end
    
 def threadPresent
  return @thread
 end 
end