require 'socket'

with_feature :unix_socket do
  describe 'UNIXSocket#path' do
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

    describe 'for a server socket' do
      it 'returns the socket path as a String' do
        @server.path.should == @path
      end
    end

    describe 'for a client socket' do
      it 'returns an empty String' do
        @client.path.should == ''
      end
    end
  end
end
