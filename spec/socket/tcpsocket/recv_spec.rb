require 'socket'

describe 'TCPSocket#recv' do
  each_ip_protocol do |family, ip_address|
    before do
      @server = TCPServer.new(ip_address, 0)
      @client = TCPSocket.new(ip_address, @server.connect_address.ip_port)
    end

    after do
      @client.close
      @server.close
    end

    it 'returns the message data' do
      @client.write('hello')

      socket = @server.accept

      begin
        socket.recv(5).should == 'hello'
      ensure
        socket.close
      end
    end
  end
end
