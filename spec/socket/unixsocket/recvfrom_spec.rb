require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#recvfrom' do
    describe 'using regular UNIX sockets' do
      before do
        @path   = tmp('unix_socket')
        @server = UNIXServer.new(@path)
        @client = UNIXSocket.new(@path)
      end

      after do
        @client.close
        @server.close

        rm_r(@path)
      end

      it 'returns an Array containing the data and address information' do
        @client.write('hello')

        connection = @server.accept

        begin
          connection.recvfrom(5).should == ['hello', ['AF_UNIX', '']]
        ensure
          connection.close
        end
      end
    end

    describe 'using a socket pair' do
      before do
        @client, @server = UNIXSocket.socketpair

        @client.write('hello')
      end

      after do
        @client.close
        @server.close
      end

      it 'returns an Array containing the data and address information' do
        @server.recvfrom(5).should == ['hello', ['AF_UNIX', '']]
      end
    end

    # These specs are taken from the rdoc examples on UNIXSocket#recvfrom.
    describe 'using a UNIX socket constructed using UNIXSocket.for_fd' do
      before do
        @path1 = tmp('unix_socket1')
        @path2 = tmp('unix_socket2')

        @client_raw = Socket.new(:UNIX, :DGRAM)
        @client_raw.bind(Socket.sockaddr_un(@path1))

        @server_raw = Socket.new(:UNIX, :DGRAM)
        @server_raw.bind(Socket.sockaddr_un(@path2))

        @socket = UNIXSocket.for_fd(@server_raw.fileno)
      end

      after do
        @client_raw.close
        @server_raw.close # also closes @socket

        rm_r(@path1)
        rm_r(@path2)
      end

      it 'returns an Array containing the data and address information' do
        @client_raw.send('hello', 0, Socket.sockaddr_un(@path2))

        @socket.recvfrom(5).should == ['hello', ['AF_UNIX', @path1]]
      end
    end
  end
end
