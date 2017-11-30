require 'socket'

describe 'Addrinfo.ip' do
  each_ip_protocol do |family, ip_address|
    it 'returns an Addrinfo instance' do
      Addrinfo.ip(ip_address).should be_an_instance_of(Addrinfo)
    end

    it 'sets the IP address' do
      Addrinfo.ip(ip_address).ip_address.should == ip_address
    end

    it 'sets the port to 0' do
      Addrinfo.ip(ip_address).ip_port.should == 0
    end

    it 'sets the address family' do
      Addrinfo.ip(ip_address).afamily.should == family
    end

    it 'sets the protocol family' do
      Addrinfo.ip(ip_address).pfamily.should == family
    end

    it 'sets the socket type to 0' do
      Addrinfo.ip(ip_address).socktype.should == 0
    end
  end
end
