require 'socket'

describe 'BasicSocket#setsockopt' do
  describe 'using a STREAM socket' do
    before do
      @socket = Socket.new(:INET, :STREAM)
    end

    after do
      @socket.close
    end

    describe 'using separate arguments with Symbols' do
      it 'raises TypeError when the first argument is nil' do
        proc { @socket.setsockopt(nil, :REUSEADDR, true) }
          .should raise_error(TypeError)
      end

      it 'sets a boolean option' do
        @socket.setsockopt(:SOCKET, :REUSEADDR, true).should == 0

        @socket.getsockopt(:SOCKET, :REUSEADDR).bool.should == true
      end

      it 'sets an integer option' do
        @socket.setsockopt(:IP, :TTL, 255).should == 0

        @socket.getsockopt(:IP, :TTL).int.should == 255
      end

      it 'sets an IPv6 boolean option' do
        socket = Socket.new(:INET6, :STREAM)

        socket.setsockopt(:IPV6, :V6ONLY, true).should == 0

        socket.getsockopt(:IPV6, :V6ONLY).bool.should == true
      end

      it 'raises Errno::EINVAL when setting an invalid option value' do
        proc { @socket.setsockopt(:SOCKET, :OOBINLINE, 'bla') }
          .should raise_error(Errno::EINVAL)
      end
    end

    describe 'using separate arguments with Symbols' do
      it 'sets a boolean option' do
        @socket.setsockopt('SOCKET', 'REUSEADDR', true).should == 0

        @socket.getsockopt(:SOCKET, :REUSEADDR).bool.should == true
      end

      it 'sets an integer option' do
        @socket.setsockopt('IP', 'TTL', 255).should == 0

        @socket.getsockopt(:IP, :TTL).int.should == 255
      end
    end

    describe 'using separate arguments with constants' do
      it 'sets a boolean option' do
        @socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
          .should == 0

        @socket.getsockopt(:SOCKET, :REUSEADDR).bool.should == true
      end

      it 'sets an integer option' do
        @socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL, 255).should == 0

        @socket.getsockopt(:IP, :TTL).int.should == 255
      end
    end

    describe 'using separate arguments with custom objects' do
      it 'sets a boolean option' do
        level = mock(:level)
        name  = mock(:name)

        level.stub!(:to_str).and_return('SOCKET')
        name.stub!(:to_str).and_return('REUSEADDR')

        @socket.setsockopt(level, name, true).should == 0
      end
    end

    describe 'using a Socket::Option as the first argument' do
      it 'sets a boolean option' do
        @socket.setsockopt(Socket::Option.bool(:INET, :SOCKET, :REUSEADDR, true))
          .should == 0

        @socket.getsockopt(:SOCKET, :REUSEADDR).bool.should == true
      end

      it 'sets an integer option' do
        @socket.setsockopt(Socket::Option.int(:INET, :IP, :TTL, 255)).should == 0

        @socket.getsockopt(:IP, :TTL).int.should == 255
      end

      it 'raises ArgumentError when passing 2 arguments' do
        option = Socket::Option.bool(:INET, :SOCKET, :REUSEADDR, true)

        proc { @socket.setsockopt(option, :REUSEADDR) }
          .should raise_error(ArgumentError)
      end

      it 'raises TypeError when passing 3 arguments' do
        option = Socket::Option.bool(:INET, :SOCKET, :REUSEADDR, true)

        proc { @socket.setsockopt(option, :REUSEADDR, true) }
          .should raise_error(TypeError)
      end
    end
  end

  describe 'using a UNIX socket' do
    before do
      @path   = tmp('unix_socket')
      @server = UNIXServer.new(@path)
    end

    after do
      @server.close
      rm_r(@path)
    end

    it 'sets a boolean option' do
      @server.setsockopt(:SOCKET, :REUSEADDR, true)
      @server.getsockopt(:SOCKET, :REUSEADDR).bool.should == true
    end
  end
end
