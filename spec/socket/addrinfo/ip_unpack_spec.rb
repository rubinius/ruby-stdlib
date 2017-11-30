require 'socket'

describe 'Addrinfo#ip_unpack' do
  each_ip_protocol do |family, ip_address|
    it 'returns the IP address and port number' do
      Addrinfo.tcp(ip_address, 80).ip_unpack.should == [ip_address, 80]
    end
  end

  describe 'using a UNIX Addrinfo' do
    it 'raises SocketError' do
      addr = Addrinfo.unix('/foo')

      proc { addr.ip_unpack }.should raise_error(SocketError)
    end
  end
end
