require 'socket'

describe 'TCPServer#sysaccept' do
  each_ip_protocol do |family, ip_address|
    before do
      @server = TCPServer.new(ip_address, 0)
    end

    after do
      @server.close
    end

    describe 'without a connected client' do
      it 'blocks the caller' do
        proc { @server.sysaccept }.should block_caller
      end
    end

    describe 'with a connected client' do
      before do
        @client = TCPSocket.new(ip_address, @server.connect_address.ip_port)
      end

      after do
        @client.close
      end

      it 'returns a new file descriptor as a Fixnum' do
        fd = @server.sysaccept

        fd.should be_an_instance_of(Fixnum)
        fd.should_not == @client.fileno
      end
    end
  end
end
