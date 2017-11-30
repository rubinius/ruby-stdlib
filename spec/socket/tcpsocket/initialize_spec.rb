require 'socket'

describe 'TCPSocket#initialize' do
  each_ip_protocol do |family, ip_address|
    describe 'when no server is listening on the given address' do
      it 'raises Errno::ECONNREFUSED' do
        proc { TCPSocket.new(ip_address, 666) }
          .should raise_error(Errno::ECONNREFUSED)
      end
    end

    describe 'when a server is listening on the given address' do
      before do
        @server = TCPServer.new(ip_address, 0)
        @port   = @server.connect_address.ip_port
      end

      after do
        @server.close
      end

      it 'returns a TCPSocket when using a Fixnum as the port' do
        TCPSocket.new(ip_address, @port).should be_an_instance_of(TCPSocket)
      end

      it 'returns a TCPSocket when using a String as the port' do
        TCPSocket.new(ip_address, @port.to_s).should be_an_instance_of(TCPSocket)
      end

      it 'raises SocketError when the port number is a non numeric String' do
        proc { TCPSocket.new(ip_address, 'cats') }.should raise_error(SocketError)
      end

      it 'set the socket to binmode' do
        TCPSocket.new(ip_address, @port).binmode?.should be_true
      end

      it 'connects to the right address' do
        socket = TCPSocket.new(ip_address, @port)

        socket.remote_address.ip_address.should == @server.local_address.ip_address
        socket.remote_address.ip_port.should    == @server.local_address.ip_port
      end

      describe 'using a local address and service' do
        it 'binds the client socket to the local address and service' do
          socket = TCPSocket.new(ip_address, @port, ip_address, 0)

          socket.local_address.ip_address.should == ip_address

          socket.local_address.ip_port.should > 0
          socket.local_address.ip_port.should_not == @port
        end
      end
    end
  end
end
