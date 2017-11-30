require 'socket'

describe 'Addrinfo#canonname' do
  describe 'when the canonical name is available' do
    it 'returns the canonical name as a String' do
      args  = ['localhost', nil, :INET, :STREAM, nil, Socket::AI_CANONNAME]
      canon = Socket.getaddrinfo(*args)[0][2]
      addrs = Addrinfo.getaddrinfo(*args)

      addrs[0].canonname.should == canon
    end
  end

  describe 'when the canonical name is not available' do
    it 'returns nil' do
      addr = Addrinfo.new(Socket.sockaddr_in(0, '127.0.0.1'))

      addr.canonname.should be_nil
    end
  end
end
