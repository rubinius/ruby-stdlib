require 'socket'

describe 'Addrinfo#pfamily' do
  it 'returns PF_UNSPEC as the default socket family' do
    sockaddr = Socket.pack_sockaddr_in(80, 'localhost')

    Addrinfo.new(sockaddr).pfamily.should == Socket::PF_UNSPEC
  end

  it 'returns PF_UNSPEC as the default socket family for Unix sockets' do
    sockaddr = Socket.pack_sockaddr_un('socket')

    Addrinfo.new(sockaddr).pfamily.should == Socket::PF_UNSPEC
  end
end
