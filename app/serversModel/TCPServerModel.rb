class TCPServerModel < ServerModel
 def serviceTCP
  TCPServer.open(Config::MACHINE_IP, Config::SERVER_PORT_MA) {|serv|
   while socket = serv.accept
    ClientTCPModel.new(socket, @config)
   end
  }
 end
    
 def runner
  serviceTCP()
 end 
    
 def stopRunner() 
 end
end