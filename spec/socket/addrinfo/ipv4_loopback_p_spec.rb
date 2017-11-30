require 'socket'

describe 'Addrinfo#ipv4_loopback?' do
  it 'returns true for an IPv4 loopback address' do
    Addrinfo.ip('127.0.0.1').ipv4_loopback?.should == true
    Addrinfo.ip('127.0.0.2').ipv4_loopback?.should == true
    Addrinfo.ip('127.255.0.1').ipv4_loopback?.should == true
    Addrinfo.ip('127.255.255.255').ipv4_loopback?.should == true
  end

  it 'returns false for a regular IPv4 address' do
    Addrinfo.ip('255.255.255.0').ipv4_loopback?.should == false
  end

  it 'returns false for an IPv6 address' do
    Addrinfo.ip('::1').ipv4_loopback?.should == false
  end
end
