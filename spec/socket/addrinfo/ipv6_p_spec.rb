require 'socket'

describe 'Addrinfo#ipv6?' do
  describe 'using an IPv6 address' do
    it 'returns true' do
      addr = Addrinfo.new(['AF_INET6', 80, 'localhost', '::1'])

      addr.ipv6?.should == true
    end
  end

  describe 'using an IPv4 address' do
    it 'returns false' do
      addr = Addrinfo.new(['AF_INET', 80, 'localhost', '127.0.0.1'])

      addr.ipv6?.should == false
    end
  end
end
