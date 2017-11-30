require 'socket'

describe 'TCPServer#accept' do
  each_ip_protocol do |family, ip_address|
    before do
      @server = TCPServer.new(ip_address, 0)
    end

    after do
      @server.close
    end

    describe 'without a connected client' do
      it 'blocks the caller' do
        proc { @server.accept }.should block_caller
      end
    end

    describe 'with a connected client' do
      before do
        @client = TCPSocket.new(ip_address, @server.connect_address.ip_port)
      end

      after do
        @client.close
      end

      it 'returns a TCPSocket' do
        @server.accept.should be_an_instance_of(TCPSocket)
      end
    end
  end
end
