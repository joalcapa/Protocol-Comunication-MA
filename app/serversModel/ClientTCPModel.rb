class ClientTCPModel
 def initialize(socket)
  socket.puts Time.now
  socket.close
 end
    
 def converse
     
 end

 def runner
  converse()
 end 
    
 def stopRunner
 end
end