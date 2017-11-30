require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#peeraddr' do
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
      it 'returns an Array containing the address family and the socket path' do
        @client.peeraddr.should == ['AF_UNIX', @path]
      end
    end

    describe 'for the server socket' do
      it 'raises Errno::ENOTCONN' do
        proc { @server.peeraddr }.should raise_error(Errno::ENOTCONN)
      end
    end
  end
end
