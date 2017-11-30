require 'socket'

describe 'Socket#connect_nonblock' do
  each_ip_protocol do |family, ip_address|
    describe 'using a DGRAM socket' do
      before do
        @server   = Socket.new(family, :DGRAM)
        @client   = Socket.new(family, :DGRAM)
        @sockaddr = Socket.sockaddr_in(0, ip_address)

        @server.bind(@sockaddr)
      end

      after do
        @client.close
        @server.close
      end

      it 'returns 0 when successfully connected using a String' do
        @client.connect_nonblock(@server.getsockname).should == 0
      end

      it 'returns 0 when successfully connected using an Addrinfo' do
        @client.connect_nonblock(@server.connect_address).should == 0
      end

      it 'raises TypeError when passed a Fixnum' do
        proc { @client.connect_nonblock(666) }.should raise_error(TypeError)
      end
    end

    describe 'using a STREAM socket' do
      before do
        @server   = Socket.new(family, :STREAM)
        @client   = Socket.new(family, :STREAM)
        @sockaddr = Socket.sockaddr_in(0, ip_address)
      end

      after do
        @client.close
        @server.close
      end

      it 'raises IO:EINPROGRESSWaitWritable when the connection would block' do
        @server.bind(@sockaddr)

        proc { @client.connect_nonblock(@server.getsockname) }
          .should raise_error(IO::EINPROGRESSWaitWritable)
      end
    end
  end
end
