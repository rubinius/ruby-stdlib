require 'socket'

describe 'BasicSocket#getsockopt' do
  before do
    @sock = Socket.new(:INET, :STREAM)
  end

  it 'returns a Socket::Option using a constant' do
    opt = @sock.getsockopt(Socket::SOL_SOCKET, Socket::SO_TYPE)

    opt.should be_an_instance_of(Socket::Option)
  end

  it 'returns a Socket::Option for a boolean option' do
    opt = @sock.getsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR)

    opt.bool.should == false
  end

  it 'returns a Socket::Option for a numeric option' do
    opt = @sock.getsockopt(Socket::IPPROTO_IP, Socket::IP_TTL)

    opt.int.should be_an_instance_of(Fixnum)
  end

  it 'returns a Socket::Option for a struct option' do
    opt = @sock.getsockopt(Socket::SOL_SOCKET, Socket::SO_LINGER)

    opt.linger.should == [false, 0]
  end

  it 'raises Errno::ENOPROTOOPT when requesting an invalid option' do
    proc { @sock.getsockopt(Socket::SOL_SOCKET, -1) }
      .should raise_error(Errno::ENOPROTOOPT)
  end

  describe 'using Symbols as arguments' do
    it 'returns a Socket::Option for arguments :SOCKET and :TYPE' do
      opt = @sock.getsockopt(:SOCKET, :TYPE)

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_TYPE
    end

    it 'returns a Socket::Option for arguments :IP and :TTL' do
      opt = @sock.getsockopt(:IP, :TTL)

      opt.level.should   == Socket::IPPROTO_IP
      opt.optname.should == Socket::IP_TTL
    end

    it 'returns a Socket::Option for arguments :SOCKET and :REUSEADDR' do
      opt = @sock.getsockopt(:SOCKET, :REUSEADDR)

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_REUSEADDR
    end

    it 'returns a Socket::Option for arguments :SOCKET and :LINGER' do
      opt = @sock.getsockopt(:SOCKET, :LINGER)

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_LINGER
    end

    with_feature :udp_cork do
      it 'returns a Socket::Option for arguments :UDP and :CORK' do
        sock = Socket.new(:INET, :DGRAM)
        opt  = sock.getsockopt(:UDP, :CORK)

        opt.level.should   == Socket::IPPROTO_UDP
        opt.optname.should == Socket::UDP_CORK
      end
    end
  end

  describe 'using Strings as arguments' do
    it 'returns a Socket::Option for arguments "SOCKET" and "TYPE"' do
      opt = @sock.getsockopt("SOCKET", "TYPE")

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_TYPE
    end

    it 'returns a Socket::Option for arguments "IP" and "TTL"' do
      opt = @sock.getsockopt("IP", "TTL")

      opt.level.should   == Socket::IPPROTO_IP
      opt.optname.should == Socket::IP_TTL
    end

    it 'returns a Socket::Option for arguments "SOCKET" and "REUSEADDR"' do
      opt = @sock.getsockopt("SOCKET", "REUSEADDR")

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_REUSEADDR
    end

    it 'returns a Socket::Option for arguments "SOCKET" and "LINGER"' do
      opt = @sock.getsockopt("SOCKET", "LINGER")

      opt.level.should   == Socket::SOL_SOCKET
      opt.optname.should == Socket::SO_LINGER
    end

    with_feature :udp_cork do
      it 'returns a Socket::Option for arguments "UDP" and "CORK"' do
        sock = Socket.new("INET", "DGRAM")
        opt  = sock.getsockopt("UDP", "CORK")

        opt.level.should   == Socket::IPPROTO_UDP
        opt.optname.should == Socket::UDP_CORK
      end
    end
  end

  describe 'using a String based option' do
    it 'allows unpacking of a boolean option' do
      opt = @sock.getsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR).to_s

      opt.unpack('i').should == [0]
    end

    it 'allows unpacking of a numeric option' do
      opt   = @sock.getsockopt(Socket::IPPROTO_IP, Socket::IP_TTL).to_s
      array = opt.unpack('i')

      array[0].should be_an_instance_of(Fixnum)
      array[0].should > 0
    end

    it 'allows unpacking of a struct option' do
      opt = @sock.getsockopt(Socket::SOL_SOCKET, Socket::SO_LINGER).to_s

      if opt.bytesize == 8
        opt.unpack('ii').should == [0, 0]
      else
        opt.unpack('i').should == [0]
      end
    end
  end
end
