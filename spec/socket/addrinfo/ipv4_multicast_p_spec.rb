require 'socket'

describe 'Addrinfo#ipv4_multicast?' do
  it 'returns true for a multicast address' do
    Addrinfo.ip('224.0.0.0').ipv4_multicast?.should == true
    Addrinfo.ip('224.0.0.9').ipv4_multicast?.should == true
    Addrinfo.ip('239.255.255.250').ipv4_multicast?.should == true
  end

  it 'returns false for a regular addrss' do
    Addrinfo.ip('8.8.8.8').ipv4_multicast?.should == false
  end

  it 'returns false for an IPv6 address' do
    Addrinfo.ip('::1').ipv4_multicast?.should == false
  end
end
