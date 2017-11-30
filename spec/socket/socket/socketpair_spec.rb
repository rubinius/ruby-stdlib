require 'socket'

describe 'Socket.socketpair' do
  describe 'using a Fixnum as the 1st and 2nd argument' do
    it 'returns two Socket objects' do
      s1, s2 = Socket.socketpair(Socket::AF_UNIX, Socket::SOCK_STREAM)

      s1.should be_an_instance_of(Socket)
      s2.should be_an_instance_of(Socket)
    end
  end

  describe 'using a Symbol as the 1st and 2nd argument' do
    it 'returns two Socket objects' do
      s1, s2 = Socket.socketpair(:UNIX, :STREAM)

      s1.should be_an_instance_of(Socket)
      s2.should be_an_instance_of(Socket)
    end

    it 'raises SocketError for an unknown address family' do
      proc { Socket.socketpair(:CATS, :STREAM) }.should raise_error(SocketError)
    end

    it 'raises SocketError for an unknown socket type' do
      proc { Socket.socketpair(:UNIX, :CATS) }.should raise_error(SocketError)
    end
  end

  describe 'using a String as the 1st and 2nd argument' do
    it 'returns two Socket objects' do
      s1, s2 = Socket.socketpair('UNIX', 'STREAM')

      s1.should be_an_instance_of(Socket)
      s2.should be_an_instance_of(Socket)
    end

    it 'raises SocketError for an unknown address family' do
      proc { Socket.socketpair('CATS', 'STREAM') }
        .should raise_error(SocketError)
    end

    it 'raises SocketError for an unknown socket type' do
      proc { Socket.socketpair('UNIX', 'CATS') }
        .should raise_error(SocketError)
    end
  end

  describe 'using an object that responds to #to_str as the 1st and 2nd argument' do
    it 'returns two Socket objects' do
      family = mock(:family)
      type   = mock(:type)

      family.stub!(:to_str).and_return('UNIX')
      type.stub!(:to_str).and_return('STREAM')

      s1, s2 = Socket.socketpair(family, type)

      s1.should be_an_instance_of(Socket)
      s2.should be_an_instance_of(Socket)
    end

    it 'raises TypeError when #to_str does not return a String' do
      family = mock(:family)
      type   = mock(:type)

      family.stub!(:to_str).and_return(Socket::AF_UNIX)
      type.stub!(:to_str).and_return(Socket::SOCK_STREAM)

      proc { Socket.socketpair(family, type) }.should raise_error(TypeError)
    end

    it 'raises SocketError for an unknown address family' do
      family = mock(:family)
      type   = mock(:type)

      family.stub!(:to_str).and_return('CATS')
      type.stub!(:to_str).and_return('STREAM')

      proc { Socket.socketpair(family, type) }.should raise_error(SocketError)
    end

    it 'raises SocketError for an unknown socket type' do
      family = mock(:family)
      type   = mock(:type)

      family.stub!(:to_str).and_return('UNIX')
      type.stub!(:to_str).and_return('CATS')

      proc { Socket.socketpair(family, type) }.should raise_error(SocketError)
    end
  end

  it 'accepts a custom protocol as a Fixnum as the 3rd argument' do
    s1, s2 = Socket.socketpair(:UNIX, :STREAM, Socket::IPPROTO_IP)

    s1.should be_an_instance_of(Socket)
    s2.should be_an_instance_of(Socket)
  end

  it 'connects the returned Socket objects' do
    s1, s2 = Socket.socketpair(:UNIX, :STREAM)

    s1.write('hello')
    s2.recv(5).should == 'hello'
  end
end

describe 'Socket.pair' do
  it 'is an alias of Socket.socketpair' do
    s1, s2 = Socket.pair(Socket::AF_UNIX, Socket::SOCK_STREAM)

    s1.should be_an_instance_of(Socket)
    s2.should be_an_instance_of(Socket)
  end
end
