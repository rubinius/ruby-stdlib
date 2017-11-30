require 'socket'

describe 'BasicSocket#recv' do
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
      it 'blocks the caller' do
        proc { @server.recv(4) }.should block_caller
      end
    end

    describe 'using a bound socket' do
      before do
        @server.bind(Socket.sockaddr_in(0, ip_address))
      end

      describe 'without any data available' do
        it 'blocks the caller' do
          proc { @server.recv(4) }.should block_caller
        end
      end

      describe 'with data available' do
        before do
          @client.connect(@server.getsockname)
        end

        it 'reads the given amount of bytes' do
          @client.write('hello')

          @server.recv(2).should == 'he'
        end

        it 'reads the given amount of bytes when it exceeds the data size' do
          @client.write('he')

          @server.recv(6).should == 'he'
        end

        it 'blocks the caller when called twice without new data being available' do
          @client.write('hello')

          @server.recv(2).should == 'he'

          proc { @server.recv(4) }.should block_caller
        end

        it 'takes a peek at the data when using the MSG_PEEK flag' do
          @client.write('hello')

          @server.recv(2, Socket::MSG_PEEK).should == 'he'
          @server.recv(2).should == 'he'
        end
      end
    end
  end
end
