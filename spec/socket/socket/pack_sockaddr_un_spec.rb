require 'socket'

describe 'Socket.pack_sockaddr_un' do
  platform_is :linux do
    it 'returns a String of 110 bytes' do
      str = Socket.pack_sockaddr_un('/tmp/test.sock')

      str.should be_an_instance_of(String)
      str.bytesize.should == 110
    end
  end

  platform_is :bsd do
    it 'returns a String of 106 bytes' do
      str = Socket.pack_sockaddr_un('/tmp/test.sock')

      str.should be_an_instance_of(String)
      str.bytesize.should == 106
    end
  end

  it 'raises ArgumentError for paths that are too long' do
    path = 'a' * 110

    proc { Socket.pack_sockaddr_un(path) }.should raise_error(ArgumentError)
  end
end

describe 'Socket.sockaddr_un' do
  it 'is an alias of Socket.pack_sockaddr_un' do
    path = '/tmp/test.sock'

    Socket.sockaddr_un(path).should == Socket.pack_sockaddr_un(path)
  end
end
