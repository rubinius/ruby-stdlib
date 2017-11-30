require 'socket'

describe 'Addrinfo#bind' do
  describe 'with a block' do
    before do
      @addr = Addrinfo.udp('127.0.0.1', 9999)
    end

    it 'yields a Socket' do
      @addr.bind do |socket|
        socket.should be_an_instance_of(Socket)
      end
    end
  end

  describe 'without a block' do
    it 'returns a Socket' do
      @addr.bind.should be_an_instance_of(Socket)
    end
  end
end
