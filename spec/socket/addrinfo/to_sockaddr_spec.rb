require 'socket'

describe 'Addrinfo#to_sockaddr' do
  describe 'using a Addrinfo with an IPv4 address' do
    it 'returns a String' do
      addr = Addrinfo.tcp('127.0.0.1', 80)

      addr.to_sockaddr.should == Socket.sockaddr_in(80, '127.0.0.1')
    end
  end

  describe 'using a Addrinfo with an IPv6 address' do
    it 'returns a String' do
      addr = Addrinfo.tcp('::1', 80)

      addr.to_sockaddr.should == Socket.sockaddr_in(80, '::1')
    end
  end

  describe 'using a Addrinfo with a UNIX path' do
    it 'returns a String' do
      addr = Addrinfo.unix('foo')

      addr.to_sockaddr.should == Socket.sockaddr_un('foo')
    end
  end

  describe 'using a Addrinfo with just an IP address' do
    it 'returns a String' do
      addr = Addrinfo.ip('127.0.0.1')

      addr.to_sockaddr.should == Socket.sockaddr_in(0, '127.0.0.1')
    end
  end

  describe 'using a Addrinfo without an IP and port' do
    it 'returns a String' do
      addr = Addrinfo.new(['AF_INET', 0, '', ''])

      addr.to_sockaddr.should == Socket.sockaddr_in(0, '')
    end
  end
end
