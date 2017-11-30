require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#addr' do
    before do
      @path   = tmp('unix_socket')
      @server = UNIXServer.new(@path)
      @client = UNIXSocket.new(@path)
    end

    after do
      @client.close
      @server.close

      rm_r(@path)
    end

    describe 'for the client socket' do
      it 'returns an Array containing the address family and an empty socket path' do
        @client.addr.should == ['AF_UNIX', '']
      end
    end

    describe 'for the server socket' do
      it 'returns an Array containing the address family and the socket path' do
        @server.addr.should == ['AF_UNIX', @path]
      end
    end
  end
end
