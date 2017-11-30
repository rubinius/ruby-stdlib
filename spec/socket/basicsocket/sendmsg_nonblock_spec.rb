require 'socket'

describe 'BasicSocket#sendmsg_nonblock' do
  each_ip_protocol do |family, ip_address|
    describe 'using a disconnected socket' do
      before do
        @client = Socket.new(family, :DGRAM)
        @server = Socket.new(family, :DGRAM)

        @server.bind(Socket.sockaddr_in(0, ip_address))
      end

      after do
        @client.close
        @server.close
      end

      describe 'without a destination address' do
        it 'raises Errno::EDESTADDRREQ' do
          proc { @client.sendmsg_nonblock('hello') }
            .should raise_error(Errno::EDESTADDRREQ)
        end
      end

      describe 'with a destination address as a String' do
        it 'returns the amount of sent bytes' do
          @client.sendmsg_nonblock('hello', 0, @server.getsockname)
            .should == 5
        end
      end

      describe 'with a destination address as an Addrinfo' do
        it 'returns the amount of sent bytes' do
          @client.sendmsg_nonblock('hello', 0, @server.connect_address)
            .should == 5
        end
      end
    end

    describe 'using a connected UDP socket' do
      before do
        @client = Socket.new(family, :DGRAM)
        @server = Socket.new(family, :DGRAM)

        @server.bind(Socket.sockaddr_in(0, ip_address))
      end

      after do
        @client.close
        @server.close
      end

      describe 'without a destination address argument' do
        before do
          @client.connect(@server.getsockname)
        end

        it 'returns the amount of bytes written' do
          @client.sendmsg_nonblock('hello').should == 5
        end
      end

      describe 'with a destination address argument' do
        before do
          @alt_server = Socket.new(family, :DGRAM)

          @alt_server.bind(Socket.sockaddr_in(0, ip_address))
        end

        after do
          @alt_server.close
        end

        it 'sends the message to the given address instead' do
          @client.sendmsg_nonblock('hello', 0, @alt_server.getsockname)
            .should == 5

          proc { @server.recv(5) }.should block_caller

          @alt_server.recv(5).should == 'hello'
        end
      end
    end

    describe 'using a connected TCP socket' do
      before do
        @client = Socket.new(family, :STREAM)
        @server = Socket.new(family, :STREAM)

        @server.bind(Socket.sockaddr_in(0, ip_address))
        @server.listen(1)

        @client.connect(@server.getsockname)
      end

      after do
        @client.close
        @server.close
      end

      it 'raises IO::EAGAINWaitReadable when the underlying buffer is full' do
        block = proc do
          10.times { @client.sendmsg_nonblock('hello' * 1_000_000) }
        end

        block.should raise_error(IO::EAGAINWaitReadable)
      end
    end
  end
end
