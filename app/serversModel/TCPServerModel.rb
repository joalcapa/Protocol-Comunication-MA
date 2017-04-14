class TCPServerModel < ServerModel
 def serviceTCP
 end
    
 def runner
  serviceTCP()
 end 
    
 def stopRunner() 
  #@socketUDP.close
 end
end