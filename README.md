## Protocol of Comunication MA
Communication **protocol MA** in Ruby

protocolCom, defines a communication protocol, based on the client-server architecture
both the client and the server, implement the protocols **TCP**, **UDP**.
The application is structured under the software architecture model **MVC**(Model Vista Controller)
implemented in addition the software component **DAO**(Object of Data Access).

#### Services used
* **UDPSocket**
* **TCPServer**
* **TkRoot**

``` ruby
require 'socket'
require 'tk'
require 'tkextlib/tile'
```

### Starting the application with git

Clone repository:

`
$ git clone git://github.com/joalcapa/Protocol-Comunication-MA.git
`

By entering the repository folder:

`
$ cd Protocol-Comunication-MA
`

Running the application:

`
$ ruby main.rb
`

**Main.rb** is the starting point of the application, a code block in which both the DAO object, the controller and the view are loaded
the driver is injected with the DAO object and the view, and the configuration Of the application using environment variables
set in the **.env** file

## Setting the application as server or client
The easiest way is to set values in the environment variables

`
ENV['TYPE_SERVICE'] = 'SERVER' or
ENV['TYPE_SERVICE'] = 'CLIENT'
`

### Executing the protocol on the client
By not knowing the address of the server, but knowing the port of the service, the client made a broadcast message, using the UDP protocol

``` ruby
SERVER_HOST = ENV['SERVER_HOST'] || '0.0.0.0'
BROADCAST_HOST = ENV['BROADCAST_HOST'] || '255.255.255.255'
BROADCAST_PORT = ENV['BROADCAST_PORT'] || '3000'
BROADCAST_HELLO = ENV['BROADCAST_HELLO'] || 'HELLO SERVER MA'
```

Default: **BROADCAST_PORT: 3000**

``` ruby
 def messageBroadcast
  @socketUDP = UDPSocket.new
  @socketUDP.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  @socketUDP.send(Config::BROADCAST_HELLO, 0, Config::BROADCAST_HOST, Config::BROADCAST_PORT)
  begin
   data, addr = @socketUDP.recvfrom(Config::SIZE_PACKAGE_SOCKET)
   arrayData = data.split(":")
   if arrayData.length == 2
    if arrayData[0] == Config::SERVER_HELLO
     @addrServer = addr[3]
     @portServer = arrayData[1]
     @config.setTypeOperationClient(Config::TYPE_OPERATION_CLIENT_CONVERSATION)
     @config.mutex().lock
      @status = Config::SERVER_FOUND
     @config.mutex().unlock
     @resource = ''
     @socket = TCPSocket.new @addrServer, @portServer
    end
   end
   @socketUDP.close
  rescue
   @timeSearchServer = 0
  end 
 end
```

To which the server responds, granting it the port in which it can make a connection-oriented communication, through the protocol TCP

``` ruby
def serviceUDP
  BasicSocket.do_not_reverse_lookup = true
  $socketUDP = UDPSocket.new
  $socketUDP.bind(Config::SERVER_HOST, Config::SERVER_PORT)
  data, addr = $socketUDP.recvfrom(Config::SIZE_PACKAGE_SOCKET)
  if data == Config::BROADCAST_HELLO
   $socketUDP.send Config::SERVER_HELLO_PORT, 0, addr[3], addr[1]
  end
  $socketUDP.close
end
```

Both the client and the server follow the configuration given by the protocol configuration.

``` ruby
SERVER_HELLO_PORT = ENV['SERVER_HELLO_PORT'] || 'HELLO CLIENT MA:4500'
```

Default: **PORT: 4500**

TCP communication is established, the server creates an instance for the client, in which it will be prepared to serve the requested resource, the client in turn receives the packets and forms the resource, the packet size is defined in the configuration of the application
``` ruby
SIZE_PACKAGE_DATA = 1024
```

Once the connection to the server is established, it is proposed to perform the conversation by sending the client the fragments of the size resource established by the application configuration.

``` ruby
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
```

The client receives the packets and concatenates them in an array of bytes, the controller notices the existence of the resource and sends it to the view, it is in charge of displaying the resource in context.

``` ruby
 def converse
  @config.mutex().lock
   data, addr = @socket.recvfrom(Config::SIZE_PACKAGE_DATA)
    if(data == Config::CLOSED_COMUNICATION) then
     @status = Config::DISCONNECTED_FROM_SERVER
     @socket.close
     @running = false
     @isActiveResource = true
    else
     @status = Config::DOWNLOADING_RESOURCE
     @resource = @resource + data
    end
  @config.mutex().unlock
 end
```

The view receives the byte array and presents it in context.

``` ruby
def asignDataImage(dataResource)
  @image = TkPhotoImage.new(:data => dataResource)
  @labelImage.image = @image
end
```
