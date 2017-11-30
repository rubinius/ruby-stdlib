require 'socket'

describe 'BasicSocket#getpeername' do
  before do
    @server = Socket.new(:INET, :STREAM)
    @client = Socket.new(:INET, :STREAM)

    @server.bind(Socket.sockaddr_in(0, '127.0.0.1'))
    @server.listen(1)

    @sockaddr = Socket.sockaddr_in(@server.local_address.ip_port, '127.0.0.1')

    @client.connect(@sockaddr)
  end

  after do
    @client.close
    @server.close
  end

  it 'returns a socket address as a String' do
    @client.getpeername.should == @sockaddr
  end

  it 'raises Errno::ENOTCONN for a disconnected socket' do
    proc { @server.getpeername }.should raise_error(Errno::ENOTCONN)
  end
end
