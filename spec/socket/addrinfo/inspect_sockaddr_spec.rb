require 'socket'

describe 'Addrinfo#inspect_sockaddr' do
  describe 'using an IPv4 address' do
    it 'returns a String containing the IP address and port number' do
      addr = Addrinfo.tcp('127.0.0.1', 80)

      addr.inspect_sockaddr.should == '127.0.0.1:80'
    end

    it 'returns a String containing just the IP address when no port is given' do
      addr = Addrinfo.tcp('127.0.0.1', 0)

      addr.inspect_sockaddr.should == '127.0.0.1'
    end
  end

  describe 'using an IPv6 address' do
    it 'returns a String containing the IP address and port number' do
      addr = Addrinfo.tcp('::1', 80)

      addr.inspect_sockaddr.should == '[::1]:80'
    end

    it 'returns a String containing just the IP address when no port is given' do
      addr = Addrinfo.tcp('::1', 0)

      addr.inspect_sockaddr.should == '::1'
    end
  end

  describe 'using a UNIX path' do
    it 'returns a String containing the UNIX path' do
      addr = Addrinfo.unix('/foo/bar')

      addr.inspect_sockaddr.should == '/foo/bar'
    end

    it 'returns a String containing the UNIX path when using a relative path' do
      addr = Addrinfo.unix('foo')

      addr.inspect_sockaddr.should == 'UNIX foo'
    end
  end
end
