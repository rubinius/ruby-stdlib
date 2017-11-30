require 'socket'

describe 'Addrinfo#ipv4_private?' do
  it 'returns true for a private IP address' do
    Addrinfo.ip('10.0.0.0').ipv4_private?.should == true
    Addrinfo.ip('10.0.0.5').ipv4_private?.should == true

    Addrinfo.ip('172.16.0.0').ipv4_private?.should == true
    Addrinfo.ip('172.16.0.5').ipv4_private?.should == true

    Addrinfo.ip('192.168.0.0').ipv4_private?.should == true
    Addrinfo.ip('192.168.0.5').ipv4_private?.should == true
  end

  it 'returns false for a regular IP address' do
    Addrinfo.ip('8.8.8.8').ipv4_private?.should == false
  end

  it 'returns false for an IPv6 address' do
    Addrinfo.ip('::1').ipv4_private?.should == false
  end
end
