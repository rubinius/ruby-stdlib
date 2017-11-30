require 'socket'

describe 'Addrinfo#unix?' do
  describe 'using a Unix socket' do
    it 'returns true' do
      Addrinfo.unix('socket').unix?.should == true
    end
  end

  describe 'using an AF_INET socket' do
    it 'returns false' do
      addr = Addrinfo.new(['AF_INET', 80, 'hostname', '127.0.0.1'])

      addr.unix?.should == false
    end
  end
end
