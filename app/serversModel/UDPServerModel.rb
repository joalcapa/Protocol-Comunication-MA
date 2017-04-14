class UDPServerModel < ServerModel
 def serviceUDP
  $socketUDP = UDPSocket.new
  $socketUDP.bind(Config::SERVER_HOST, Config::SERVER_PORT)
  data, addr = $socketUDP.recvfrom(1024)
  response(data, addr)
  $socketUDP.close
 end
    
 def response(data, addr)
  puts " From addr: "
     puts addr
  puts " Message: "
  puts data
 end
    
 def runner
     puts 'jeje --------------------'
  serviceUDP()
 end 
    
 def stopRunner() 
  #@socketUDP.close
 end
end