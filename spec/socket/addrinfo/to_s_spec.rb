require 'socket'

describe 'Addrinfo#to_s' do
  it 'is an alias of Addrinfo#to_sockaddr' do
    addr = Addrinfo.tcp('127.0.0.1', 80)

    addr.to_s.should == addr.to_sockaddr
  end
end
