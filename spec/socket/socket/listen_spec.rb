require 'socket'

describe 'Socket#listen' do
  each_ip_protocol do |family, ip_address|
    describe 'using a DGRAM socket' do
      before do
        @server = Socket.new(family, :DGRAM)
        @client = Socket.new(family, :DGRAM)

        @server.bind(Socket.sockaddr_in(0, ip_address))
      end

      after do
        @client.close
        @server.close
      end

      it 'raises Errno::EOPNOTSUPP' do
        proc { @server.listen(1) }.should raise_error(Errno::EOPNOTSUPP)
      end
    end

    describe 'using a STREAM socket' do
      before do
        @server = Socket.new(family, :STREAM)
        @client = Socket.new(family, :STREAM)

        @server.bind(Socket.sockaddr_in(0, ip_address))
      end

      after do
        @client.close
        @server.close
      end

      it 'returns 0' do
        @server.listen(1).should == 0
      end

      it "raises when the given argument can't be coerced to a Fixnum" do
        proc { @server.listen('cats') }.should raise_error(TypeError)
      end
    end
  end
end
