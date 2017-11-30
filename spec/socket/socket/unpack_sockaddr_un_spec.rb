require 'socket'

describe 'Socket.unpack_sockaddr_un' do
  it 'returns the socket path as a String' do
    path = '/tmp/test.sock'
    addr = Socket.pack_sockaddr_un(path)

    Socket.unpack_sockaddr_un(addr).should == path
  end
end
