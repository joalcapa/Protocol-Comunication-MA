class HomeDao
 def initialize(config)
  @config = config
  @clientServerModel = ClientServerModel.new(config, Config::TYPE_SERVICE_CLIENT)
  @serverServerModel = ServerServerModel.new(config, Config::TYPE_SERVICE_SERVER)
 end
    
 def killServer
  @clientServerModel.killServer
  @serverServerModel.killServer
 end
    
 def isClientActiveResource
  return @clientServerModel.isActiveResource()
 end
    
 def dataResource
  return @clientServerModel.dataResource()
 end
    
 def status
  if @config.getTypeService == Config::TYPE_SERVICE_CLIENT
   return @clientServerModel.getStatus
  else
   return 'service server'
  end
 end
end