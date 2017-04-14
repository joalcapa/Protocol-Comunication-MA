class ClientTCPModel
 def initialize(socket, config)
  @socket, @config, @running, @thread = socket, config, true, nil
  @countPackage, @index, @start, @length = @config.sizeArrayData/Config::SIZE_PACKAGE_DATA, 0, 0, Config::SIZE_PACKAGE_DATA
     puts @countPackage
     puts 'count'
  @thread = Thread.new{ run() }
 end
    
 def run
  while @running
   converse()
   @index++
   if @index == @countPackage
    @running = false 
   end
   sleep(1)
  end
 end
    
 def converse
     payload_with_header = CustomProtocolModule.constructMethod((@config.getSegmentArrayData(@start, @length)))
     @socket.puts(payload_with_header)
     @start = @start + @length
 end

 def runner
  converse()
 end 
    
 def stopRunner
 end
end