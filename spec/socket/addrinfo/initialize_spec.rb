require 'socket'

describe 'Addrinfo#initialize' do
  describe 'using separate arguments for a TCP socket' do
    before do
      @sockaddr = Socket.sockaddr_in(80, '127.0.0.1')
    end

    it 'returns an Addrinfo with the correct IP' do
      addr = Addrinfo.new(@sockaddr)

      addr.ip_address.should == '127.0.0.1'
    end

    it 'returns an Addrinfo with the correct port' do
      addr = Addrinfo.new(@sockaddr)

      addr.ip_port.should == 80
    end

    it 'returns an Addrinfo with AF_INET as the default address family' do
      addr = Addrinfo.new(@sockaddr)

      addr.afamily.should == Socket::AF_INET
    end

    it 'returns an Addrinfo with AF_INET6 as the address family' do
      addr = Addrinfo.new(Socket.sockaddr_in(80, '::1'))

      addr.afamily.should == Socket::AF_INET6
    end

    it 'returns an Addrinfo with PF_UNSPEC as the default protocol family' do
      addr = Addrinfo.new(@sockaddr)

      addr.pfamily.should == Socket::PF_UNSPEC
    end

    it 'returns an Addrinfo with PF_INET6 family' do
      addr = Addrinfo.new(@sockaddr, Socket::PF_INET6)

      addr.pfamily.should == Socket::PF_INET6
    end

    it 'returns an Addrinfo with the correct socket type' do
      addr = Addrinfo.new(@sockaddr, nil, Socket::SOCK_STREAM)

      addr.socktype.should == Socket::SOCK_STREAM
    end

    it 'returns an Addrinfo with the correct protocol' do
      addr = Addrinfo.new(@sockaddr, nil, 0, Socket::IPPROTO_TCP)

      addr.protocol.should == Socket::IPPROTO_TCP
    end

    describe 'with Symbols' do
      it 'returns an Addrinfo with :PF_INET  family' do
        addr = Addrinfo.new(@sockaddr, :PF_INET)

        addr.pfamily.should == Socket::PF_INET
      end

      it 'returns an Addrinfo with :INET  family' do
        addr = Addrinfo.new(@sockaddr, :INET)

        addr.pfamily.should == Socket::PF_INET
      end

      it 'returns an Addrinfo with :SOCK_STREAM as the socket type' do
        addr = Addrinfo.new(@sockaddr, nil, :SOCK_STREAM)

        addr.socktype.should == Socket::SOCK_STREAM
      end

      it 'returns an Addrinfo with :STREAM as the socket type' do
        addr = Addrinfo.new(@sockaddr, nil, :STREAM)

        addr.socktype.should == Socket::SOCK_STREAM
      end
    end

    describe 'with Strings' do
      it 'returns an Addrinfo with "PF_INET"  family' do
        addr = Addrinfo.new(@sockaddr, 'PF_INET')

        addr.pfamily.should == Socket::PF_INET
      end

      it 'returns an Addrinfo with "INET"  family' do
        addr = Addrinfo.new(@sockaddr, 'INET')

        addr.pfamily.should == Socket::PF_INET
      end

      it 'returns an Addrinfo with "SOCK_STREAM" as the socket type' do
        addr = Addrinfo.new(@sockaddr, nil, 'SOCK_STREAM')

        addr.socktype.should == Socket::SOCK_STREAM
      end

      it 'returns an Addrinfo with "STREAM" as the socket type' do
        addr = Addrinfo.new(@sockaddr, nil, 'STREAM')

        addr.socktype.should == Socket::SOCK_STREAM
      end
    end
  end

  describe 'using separate arguments for a Unix socket' do
    before do
      @sockaddr = Socket.pack_sockaddr_un('socket')
    end

    it 'returns an Addrinfo with the correct unix path' do
      Addrinfo.new(@sockaddr).unix_path.should == 'socket'
    end

    it 'returns an Addrinfo with the correct protocol family' do
      Addrinfo.new(@sockaddr).pfamily.should == Socket::PF_UNSPEC
    end

    it 'returns an Addrinfo with the correct address family' do
      Addrinfo.new(@sockaddr).afamily.should == Socket::AF_UNIX
    end
  end

  describe 'using an Array as a single argument' do
    describe 'with a valid IP address' do
      # Uses AF_INET6 since AF_INET is the default, making it harder to test if
      # our Addrinfo actually sets the family correctly.
      before do
        @sockaddr = ['AF_INET6', 80, 'hostname', '::1']
      end

      it 'returns an Addrinfo with the correct IP' do
        addr = Addrinfo.new(@sockaddr)

        addr.ip_address.should == '::1'
      end

      it 'returns an Addrinfo with the correct address family' do
        addr = Addrinfo.new(@sockaddr)

        addr.afamily.should == Socket::AF_INET6
      end

      it 'returns an Addrinfo with the correct protocol family' do
        addr = Addrinfo.new(@sockaddr)

        addr.pfamily.should == Socket::PF_INET6
      end

      it 'returns an Addrinfo with the correct port' do
        addr = Addrinfo.new(@sockaddr)

        addr.ip_port.should == 80
      end
    end

    describe 'with an invalid IP address' do
      it 'raises SocketError' do
        block = proc { Addrinfo.new(['AF_INET6', 80, 'hostname', '127.0.0.1']) }

        block.should raise_error(SocketError)
      end
    end
  end

  describe 'using an Array with extra arguments' do
    describe 'with the AF_INET6 address family and an explicit protocol family' do
      before do
        @sockaddr = ['AF_INET6', 80, 'hostname', '127.0.0.1']
      end

      it 'overwrites the protocol family with AF_INET' do
        addr = Addrinfo.new(@sockaddr, Socket::AF_INET)

        addr.afamily.should == Socket::AF_INET
      end

      it 'overwrites the protocol family with PF_INET' do
        addr = Addrinfo.new(@sockaddr, Socket::PF_INET)

        addr.afamily.should == Socket::AF_INET
      end

      # Everything except AF_INET(6)/PF_INET(6) should raise an error.
      Socket.constants.grep(/(^AF_|^PF_)(?!INET)/).each do |constant|
        it "raises SocketError when using #{constant}" do
          block = proc { Addrinfo.new(@sockaddr, Socket.const_get(constant)) }

          block.should raise_error(SocketError)
        end
      end
    end

    describe 'with the AF_INET address family and an explicit socket type' do
      before do
        @sockaddr = ['AF_INET', 80, 'hostname', '127.0.0.1']
      end

      [:SOCK_STREAM, :SOCK_DGRAM, :SOCK_RAW, :SOCK_SEQPACKET].each do |type|
        it "overwrites the socket type with #{type}" do
          value = Socket.const_get(type)
          addr  = Addrinfo.new(@sockaddr, nil, value)

          addr.socktype.should == value
        end
      end

      [:SOCK_RDM].each do |type|
        it "raises SocketError when using #{type}" do
          value = Socket.const_get(type)
          block = proc { Addrinfo.new(@sockaddr, nil, value) }

          block.should raise_error(SocketError)
        end
      end
    end

    describe 'with the AF_INET address family and an explicit socket protocol' do
      before do
        @sockaddr = ['AF_INET', 80, 'hostname', '127.0.0.1']
      end

      describe 'and no socket type is given' do
        valid = [:IPPROTO_IP, :IPPROTO_UDP, :IPPROTO_HOPOPTS]

        valid.each do |type|
          it "overwrites the protocol when using #{type} " do
            value = Socket.const_get(type)
            addr  = Addrinfo.new(@sockaddr, nil, nil, value)

            addr.protocol.should == value
          end
        end

        (Socket.constants.grep(/^IPPROTO/) - valid).each do |type|
          it "raises SocketError when using #{type} " do
            value = Socket.const_get(type)
            block = proc { Addrinfo.new(@sockaddr, nil, nil, value) }

            block.should raise_error(SocketError)
          end
        end
      end

      describe 'and the socket type is set to SOCK_DGRAM' do
        before do
          @socktype = Socket::SOCK_DGRAM
        end

        valid = [:IPPROTO_IP, :IPPROTO_UDP, :IPPROTO_HOPOPTS]

        valid.each do |type|
          it "overwrites the protocol when using #{type} " do
            value = Socket.const_get(type)
            addr  = Addrinfo.new(@sockaddr, nil, @socktype, value)

            addr.protocol.should == value
          end
        end

        (Socket.constants.grep(/^IPPROTO/) - valid).each do |type|
          it "raises SocketError when using #{type} " do
            value = Socket.const_get(type)
            block = proc { Addrinfo.new(@sockaddr, nil, @socktype, value) }

            block.should raise_error(SocketError)
          end
        end
      end

      with_feature :sock_packet do
        describe 'and the socket type is set to SOCK_PACKET' do
          before do
            @socktype = Socket::SOCK_PACKET
          end

          Socket.constants.grep(/^IPPROTO/).each do |type|
            it "raises SocketError when using #{type} " do
              value = Socket.const_get(type)
              block = proc { Addrinfo.new(@sockaddr, nil, @socktype, value) }

              block.should raise_error(SocketError)
            end
          end
        end
      end

      describe 'and the socket type is set to SOCK_RAW' do
        before do
          @socktype = Socket::SOCK_RAW
        end

        Socket.constants.grep(/^IPPROTO/).each do |type|
          it "overwrites the protocol when using #{type} " do
            value = Socket.const_get(type)
            addr  = Addrinfo.new(@sockaddr, nil, @socktype, value)

            addr.protocol.should == value
          end
        end
      end

      describe 'and the socket type is set to SOCK_RDM' do
        before do
          @socktype = Socket::SOCK_RDM
        end

        Socket.constants.grep(/^IPPROTO/).each do |type|
          it "raises SocketError when using #{type} " do
            value = Socket.const_get(type)
            block = proc { Addrinfo.new(@sockaddr, nil, @socktype, value) }

            block.should raise_error(SocketError)
          end
        end
      end

      describe 'and the socket type is set to SOCK_SEQPACKET' do
        before do
          @socktype = Socket::SOCK_SEQPACKET
        end

        valid = [:IPPROTO_IP, :IPPROTO_HOPOPTS]

        valid.each do |type|
          it "overwrites the protocol when using #{type} " do
            value = Socket.const_get(type)
            addr  = Addrinfo.new(@sockaddr, nil, @socktype, value)

            addr.protocol.should == value
          end
        end

        (Socket.constants.grep(/^IPPROTO/) - valid).each do |type|
          it "raises SocketError when using #{type} " do
            value = Socket.const_get(type)
            block = proc { Addrinfo.new(@sockaddr, nil, @socktype, value) }

            block.should raise_error(SocketError)
          end
        end
      end

      describe 'and the socket type is set to SOCK_STREAM' do
        before do
          @socktype = Socket::SOCK_STREAM
        end

        valid = [:IPPROTO_IP, :IPPROTO_TCP, :IPPROTO_HOPOPTS]

        valid.each do |type|
          it "overwrites the protocol when using #{type} " do
            value = Socket.const_get(type)
            addr  = Addrinfo.new(@sockaddr, nil, @socktype, value)

            addr.protocol.should == value
          end
        end

        (Socket.constants.grep(/^IPPROTO/) - valid).each do |type|
          it "raises SocketError when using #{type} " do
            value = Socket.const_get(type)
            block = proc { Addrinfo.new(@sockaddr, nil, @socktype, value) }

            block.should raise_error(SocketError)
          end
        end
      end
    end
  end
end
