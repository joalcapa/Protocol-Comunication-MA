class ClientTCPModel
 def initialize(socket)
  @socket = socket
 end
    
 def converse
  #socket.puts Time.now
  #socket.close
 end

 def runner
  converse()
 end 
    
 def stopRunner
 end
end