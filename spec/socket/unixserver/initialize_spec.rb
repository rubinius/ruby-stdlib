require 'socket'

with_feature :unix_socket do
  describe 'UNIXServer#initialize' do
    before do
      @path = tmp('unix_socket')
    end

    after do
      rm_r(@path)
    end

    it 'returns a new UNIXServer' do
      UNIXServer.new(@path).should be_an_instance_of(UNIXServer)
    end

    it 'sets the socket to binmode' do
      UNIXServer.new(@path).binmode?.should be_true
    end

    it 'raises Errno::EADDRINUSE when the socket is already in use' do
      UNIXServer.new(@path)

      proc { UNIXServer.new(@path) }.should raise_error(Errno::EADDRINUSE)
    end
  end
end
