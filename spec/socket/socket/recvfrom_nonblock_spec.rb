require 'socket'

describe 'Socket#recvfrom_nonblock' do
  each_ip_protocol do |family, ip_address|
    before do
      @server = Socket.new(family, :DGRAM)
      @client = Socket.new(family, :DGRAM)
    end

    after do
      @client.close
      @server.close
    end

    describe 'using an unbound socket' do
      it 'raises IO::EAGAINWaitReadable' do
        proc { @server.recvfrom_nonblock(1) }
          .should raise_error(IO::EAGAINWaitReadable)
      end
    end

    describe 'using a bound socket' do
      before do
        @server.bind(Socket.sockaddr_in(0, ip_address))
        @client.connect(@server.getsockname)
      end

      describe 'without any data available' do
        it 'raises IO::EAGAINWaitReadable' do
          proc { @server.recvfrom_nonblock(1) }
            .should raise_error(IO::EAGAINWaitReadable)
        end
      end

      describe 'with data available' do
        before do
          @client.write('hello')
        end

        it 'returns an Array containing the data and an Addrinfo' do
          ret = @server.recvfrom_nonblock(1)

          ret.should be_an_instance_of(Array)
          ret.length.should == 2
        end

        describe 'the returned data' do
          it 'is the same as the sent data' do
            5.times do
              @client.write('hello')

              msg, _ = @server.recvfrom_nonblock(5)

              msg.should == 'hello'
            end
          end
        end

        describe 'the returned Array' do
          before do
            @array = @server.recvfrom_nonblock(1)
          end

          it 'contains the data at index 0' do
            @array[0].should == 'h'
          end

          it 'contains an Addrinfo at index 1' do
            @array[1].should be_an_instance_of(Addrinfo)
          end
        end

        describe 'the returned Addrinfo' do
          before do
            @addr = @server.recvfrom_nonblock(1)[1]
          end

          it 'uses AF_INET as the address family' do
            @addr.afamily.should == family
          end

          it 'uses SOCK_DGRAM as the socket type' do
            @addr.socktype.should == Socket::SOCK_DGRAM
          end

          it 'uses PF_INET as the protocol family' do
            @addr.pfamily.should == family
          end

          it 'uses 0 as the protocol' do
            @addr.protocol.should == 0
          end

          it 'uses the IP address of the client' do
            @addr.ip_address.should == ip_address
          end

          it 'uses the port of the client' do
            @addr.ip_port.should == @client.local_address.ip_port
          end
        end
      end
    end
  end
end
