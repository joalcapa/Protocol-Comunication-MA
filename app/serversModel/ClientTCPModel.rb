class ClientTCPModel
 def initialize(socket, config)
  @socket, @config, @running, @thread = socket, config, true, nil
  @countPackage, @index, @start, @length = @config.sizeArrayData/Config::SIZE_PACKAGE_DATA, 0, 0, Config::SIZE_PACKAGE_DATA
  @sizeArray = @config.sizeArrayData
  @thread = Thread.new{ run() }
 end
    
 def run
  while @running
   converse()
   sleep(1)
  end
  @socket.write(Config::CLOSED_COMUNICATION)
 end
    
 def converse
  if @index <= @countPackage then
   @socket.write(@config.getSegmentArrayData(@start, @length))
  end
  @index = @index + 1
  @start = @start + @length
  case @index
  when @countPackage
   @length = @sizeArray - @start
  when @countPackage + 1
   @running = false
  end
 end

 def runner
  converse()
 end 
    
 def stopRunner
 end
end