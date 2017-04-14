class ServerServerModel < ServerModel
 def initResource
  @UDPServerModel = UDPServerModel.new(@config, Config::TYPE_SERVICE_SERVER)
  @TCPServerModel = TCPServerModel.new(@config, Config::TYPE_SERVICE_SERVER)
 end
    
 def handlerUDPTCP
 end
    
 def runner
  handlerUDPTCP()
 end 
    
 def stopRunner
  @UDPServerModel.killServer
  @TCPServerModel.killServer
 end
    
 def bytesData(route)
 end
end