require 'socket'

describe 'BasicSocket#recv_nonblock' do
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
        proc { @server.recv_nonblock(1) }
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
          proc { @server.recv_nonblock(1) }
            .should raise_error(IO::EAGAINWaitReadable)
        end
      end

      describe 'with data available' do
        it 'returns the given amount of bytes' do
          @client.write('hello')

          IO.select([@server], nil, nil, 5)

          @server.recv_nonblock(2).should == 'he'
        end
      end
    end
  end
end
