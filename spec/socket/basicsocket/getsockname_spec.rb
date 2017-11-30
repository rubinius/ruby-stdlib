require 'socket'

describe 'BasicSocket#getsockname' do
  before do
    @server = Socket.new(:INET, :STREAM)
  end

  after do
    @server.close
  end

  it 'returns a socket address as a String' do
    @server.bind(Socket.sockaddr_in(0, '127.0.0.1'))

    addr = Socket.sockaddr_in(@server.local_address.ip_port, '127.0.0.1')

    @server.getsockname.should == addr
  end

  it 'returns a default socket address for a disconnected socket' do
    @server.getsockname.should == Socket.sockaddr_in(0, '0.0.0.0')
  end
end
