require 'socket'

describe 'BasicSocket#getpeereid' do
  with_feature :unix_socket do
    describe 'using a UNIXSocket' do
      before do
        @path   = tmp('basic_socket_getpeereid_spec.sock', false)
        @server = UNIXServer.new(@path)
        @client = UNIXSocket.new(@path)
      end

      after do
        @client.close
        @server.close

        rm_r(@path)
      end

      it 'returns an Array with the user and group ID' do
        @client.getpeereid.should == [Process.euid, Process.egid]
      end
    end
  end

  describe 'using an IPSocket' do
    it 'raises NoMethodError' do
      sock = TCPServer.new('127.0.0.1', 0)

      proc { sock.getpeereid }.should raise_error(NoMethodError)
    end
  end
end
