class UDPServerModel < ServerModel
 def serviceUDP
  BasicSocket.do_not_reverse_lookup = true
  $socketUDP = UDPSocket.new
  $socketUDP.bind(Config::SERVER_HOST, Config::SERVER_PORT)
  data, addr = $socketUDP.recvfrom(1024)
  if data == Config::BROADCAST_HELLO
   $socketUDP.send Config::SERVER_HELLO_PORT, 0, addr[3], addr[1]
  end
  $socketUDP.close
 end
    
 def runner
  serviceUDP()
 end 
    
 def stopRunner() 
 end
end