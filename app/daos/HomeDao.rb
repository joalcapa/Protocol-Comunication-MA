class HomeDao
 def initialize(config)
  @config = config
  if(config.getTypeService == Config::TYPE_SERVICE_CLIENT)
   @clientServerModel = ClientServerModel.new(config)
  else
   @serverServerModel = ServerServerModel.new(config)
  end
 end
    
 def killServer
  if(@config.getTypeService == Config::TYPE_SERVICE_CLIENT)   
   @clientServerModel.killServer
  else
   @serverServerModel.killServer
  end
 end
    
 def isClientActiveResource
  if(@config.getTypeService == Config::TYPE_SERVICE_CLIENT)
   return @clientServerModel.isActiveResource()
  else
   return false
  end
 end
    
 def dataResource
  return @clientServerModel.dataResource()
 end
    
 def getStatus
  if(@config.getTypeService == Config::TYPE_SERVICE_CLIENT)
   return @clientServerModel.getStatus()
  else
   return Config::MESSAGE_SERVER
  end
 end
end