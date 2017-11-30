require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#send_io' do
    before do
      @file = File.open('/dev/null', 'w')

      @client, @server = UNIXSocket.socketpair
    end

    after do
      @client.close
      @server.close

      @file.close
    end

    it 'sends an IO object' do
      @client.send_io(@file)

      @server.recv_io.should be_an_instance_of(IO)
    end
  end
end
