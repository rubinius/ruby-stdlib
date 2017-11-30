require 'socket'

describe 'Addrinfo#ipv6_multicast?' do
  it 'returns true for a multi-cast address' do
    Addrinfo.ip('ff00::').ipv6_multicast?.should == true
    Addrinfo.ip('ff00::1').ipv6_multicast?.should == true
    Addrinfo.ip('ff08::1').ipv6_multicast?.should == true
    Addrinfo.ip('fff8::1').ipv6_multicast?.should == true

    Addrinfo.ip('ff02::').ipv6_multicast?.should == true
    Addrinfo.ip('ff0f::').ipv6_multicast?.should == true
  end

  it 'returns false for a non multi-cast address' do
    Addrinfo.ip('::1').ipv6_multicast?.should == false
    Addrinfo.ip('fe80::').ipv6_multicast?.should == false
  end

  it 'returns false for an IPv4 address' do
    Addrinfo.ip('127.0.0.1').ipv6_multicast?.should == false
  end
end
