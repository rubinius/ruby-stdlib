require 'socket'

describe 'Addrinfo#afamily' do
  it 'returns AF_INET when using an IPv4 address' do
    sockaddr = Socket.pack_sockaddr_in(80, '127.0.0.1')

    Addrinfo.new(sockaddr).afamily.should == Socket::AF_INET
  end

  it 'returns AF_INET6 when using an IPv6 address' do
    sockaddr = Socket.pack_sockaddr_in(80, '::1')

    Addrinfo.new(sockaddr).afamily.should == Socket::AF_INET6
  end

  it 'returns AF_UNIX when using a UNIX socket' do
    sockaddr = Socket.pack_sockaddr_un('socket')

    Addrinfo.new(sockaddr).afamily.should == Socket::AF_UNIX
  end
end
