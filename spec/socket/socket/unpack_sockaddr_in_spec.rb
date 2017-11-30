require 'socket'

describe 'Socket.unpack_sockaddr_in' do
  describe 'using an IPv4 address' do
    it 'returns an Array containing the port and IP address' do
      port = 80
      ip   = '127.0.0.1'
      addr = Socket.pack_sockaddr_in(port, ip)

      Socket.unpack_sockaddr_in(addr).should == [port, ip]
    end
  end

  describe 'using an IPv6 address' do
    it 'returns an Array containing the port and IP address' do
      port = 80
      ip   = '::1'
      addr = Socket.pack_sockaddr_in(port, ip)

      Socket.unpack_sockaddr_in(addr).should == [port, ip]
    end
  end
end
