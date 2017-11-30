require 'socket'

describe 'Addrinfo#ip?' do
  it 'returns true for an IPv4 address' do
    Addrinfo.ip('127.0.0.1').ip?.should == true
  end

  it 'returns true for an IPv6 address' do
    Addrinfo.ip('::1').ip?.should == true
  end

  it 'returns false for a UNIX path' do
    Addrinfo.unix('foo').ip?.should == false
  end
end
