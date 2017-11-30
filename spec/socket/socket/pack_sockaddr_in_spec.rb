require 'socket'

describe 'Socket.pack_sockaddr_in' do
  describe 'using an IPv4 address' do
    it 'returns a String of 16 bytes' do
      str = Socket.pack_sockaddr_in(80, '127.0.0.1')

      str.should be_an_instance_of(String)
      str.bytesize.should == 16
    end
  end

  describe 'using an IPv6 address' do
    it 'returns a String of 28 bytes' do
      str = Socket.pack_sockaddr_in(80, '::1')

      str.should be_an_instance_of(String)
      str.bytesize.should == 28
    end
  end
end

describe 'Socket.sockaddr_in' do
  it 'is an alias of Socket.pack_sockaddr_in' do
    port = 80
    ip   = '127.0.0.1'

    Socket.sockaddr_in(port, ip).should == Socket.pack_sockaddr_in(port, ip)
  end
end
