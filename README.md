## protocolCom
Communication protocol for Ruby

protocolCom, defines a communication protocol, based on the client-server architecture
both the client and the server, implement the protocols **TCP**, **UDP**.
The application is structured under the software architecture model **MVC**(Model Vista Controller)
implemented in addition the software component **DAO**(Object of Data Access).

#### Services used
* **UDPSocket**
* **TCPServer**
* **TkRoot**

### Starting the application from windows cmd
`
ruby main.rb
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
def messageBroadcast
 #Message broadcast, searching server
end
```

To which the server responds, granting it the port in which it can make a connection-oriented communication, through the protocol TCP

``` ruby
def serviceUDP
 #Port assignment for tcp communication 
end
```

Both the client and the server follow the configuration given by the protocol configuration.

TCP communication is established, the server creates an instance for the client, in which it will be prepared to serve the requested resource, the client in turn receives the packets and forms the resource, the packet size is defined in the configuration of the application
``` ruby
SIZE_PACKAGE_DATA = 1024
```
