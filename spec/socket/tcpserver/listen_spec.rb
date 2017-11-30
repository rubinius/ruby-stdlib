require 'socket'

describe 'TCPServer#listen' do
  each_ip_protocol do |family, ip_address|
    before do
      @server = TCPServer.new(ip_address, 0)
    end

    after do
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
