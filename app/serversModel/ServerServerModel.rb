class ServerServerModel < ServerModel
 def initResource
  @UDPServerModel = UDPServerModel.new(@config)
  @TCPServerModel = TCPServerModel.new(@config)
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
end