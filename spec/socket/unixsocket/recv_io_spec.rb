require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#recv_io' do
    before do
      @file = File.open('/dev/null', 'w')

      @client, @server = UNIXSocket.socketpair
    end

    after do
      @client.close
      @server.close

      @file.close
    end

    describe 'without a custom class' do
      it 'returns an IO' do
        @client.send_io(@file)

        @server.recv_io.should be_an_instance_of(IO)
      end
    end

    describe 'with a custom class' do
      it 'returns an instance of the custom class' do
        @client.send_io(@file)

        @server.recv_io(File).should be_an_instance_of(File)
      end
    end

    describe 'with a custom mode' do
      it 'opens the IO using the given mode' do
        @client.send_io(@file)

        @server.recv_io(File, File::WRONLY).should be_an_instance_of(File)
      end
    end
  end
end
