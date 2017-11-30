require 'socket'

describe 'Addrinfo#socktype' do
  it 'returns 0 by default' do
    Addrinfo.ip('127.0.0.1').socktype.should == 0
  end

  it 'returns the socket type when given' do
    Addrinfo.tcp('127.0.0.1', 80).socktype.should == Socket::SOCK_STREAM
  end
end
