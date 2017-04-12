class HomeDao
 def initialize(config)
  @clientServerModel = ClientServerModel.new(config, Config::TYPE_SERVICE_CLIENT)
  @serverServerModel = ServerServerModel.new(config, Config::TYPE_SERVICE_SERVER)
 end
    
 def killServer
  @clientServerModel.killServer
  @serverServerModel.killServer
 end
end