require 'socket'

describe 'Socket.getaddrinfo' do
  describe 'without global reverse lookups' do
    it 'returns an Array' do
      Socket.getaddrinfo(nil, 'http').should be_an_instance_of(Array)
    end

    it 'accepts a Fixnum as the address family' do
      array = Socket.getaddrinfo(nil, 'http', Socket::AF_INET)[0]

      array[0].should == 'AF_INET'
      array[1].should == 80
      array[2].should == '127.0.0.1'
      array[3].should == '127.0.0.1'
      array[4].should == Socket::AF_INET
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a Fixnum as the address family using IPv6' do
      array = Socket.getaddrinfo(nil, 'http', Socket::AF_INET6)[0]

      array[0].should == 'AF_INET6'
      array[1].should == 80
      array[2].should == '::1'
      array[3].should == '::1'
      array[4].should == Socket::AF_INET6
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a Symbol as the address family' do
      array = Socket.getaddrinfo(nil, 'http', :INET)[0]

      array[0].should == 'AF_INET'
      array[1].should == 80
      array[2].should == '127.0.0.1'
      array[3].should == '127.0.0.1'
      array[4].should == Socket::AF_INET
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a Symbol as the address family using IPv6' do
      array = Socket.getaddrinfo(nil, 'http', :INET6)[0]

      array[0].should == 'AF_INET6'
      array[1].should == 80
      array[2].should == '::1'
      array[3].should == '::1'
      array[4].should == Socket::AF_INET6
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a String as the address family' do
      array = Socket.getaddrinfo(nil, 'http', 'INET')[0]

      array[0].should == 'AF_INET'
      array[1].should == 80
      array[2].should == '127.0.0.1'
      array[3].should == '127.0.0.1'
      array[4].should == Socket::AF_INET
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a String as the address family using IPv6' do
      array = Socket.getaddrinfo(nil, 'http', 'INET6')[0]

      array[0].should == 'AF_INET6'
      array[1].should == 80
      array[2].should == '::1'
      array[3].should == '::1'
      array[4].should == Socket::AF_INET6
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts an object responding to #to_str as the host' do
      dummy = mock(:dummy)

      dummy.stub!(:to_str).and_return('127.0.0.1')

      array = Socket.getaddrinfo(dummy, 'http')[0]

      array[0].should == 'AF_INET'
      array[1].should == 80
      array[2].should == '127.0.0.1'
      array[3].should == '127.0.0.1'
      array[4].should == Socket::AF_INET
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts an object responding to #to_str as the address family' do
      dummy = mock(:dummy)

      dummy.stub!(:to_str).and_return('INET')

      array = Socket.getaddrinfo(nil, 'http', dummy)[0]

      array[0].should == 'AF_INET'
      array[1].should == 80
      array[2].should == '127.0.0.1'
      array[3].should == '127.0.0.1'
      array[4].should == Socket::AF_INET
      array[5].should be_an_instance_of(Fixnum)
      array[6].should be_an_instance_of(Fixnum)
    end

    it 'accepts a Fixnum as the socket type' do
      Socket.getaddrinfo(nil, 'http', :INET, Socket::SOCK_STREAM)[0].should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end

    it 'accepts a Symbol as the socket type' do
      Socket.getaddrinfo(nil, 'http', :INET, :STREAM)[0].should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end

    it 'accepts a String as the socket type' do
      Socket.getaddrinfo(nil, 'http', :INET, 'STREAM')[0].should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end

    it 'accepts an object responding to #to_str as the socket type' do
      dummy = mock(:dummy)

      dummy.stub!(:to_str).and_return('STREAM')

      Socket.getaddrinfo(nil, 'http', :INET, dummy)[0].should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end

    it 'accepts a Fixnum as the protocol family' do
      addr = Socket.getaddrinfo(nil, 'http', :INET, :DGRAM, Socket::IPPROTO_UDP)

      addr[0].should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_DGRAM,
        Socket::IPPROTO_UDP
      ]
    end

    it 'accepts a Fixnum as the flags' do
      addr = Socket.getaddrinfo(nil, 'http', :INET, :STREAM,
                                Socket::IPPROTO_TCP, Socket::AI_PASSIVE)

      addr[0].should == [
        'AF_INET',
        80,
        '0.0.0.0',
        '0.0.0.0',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end

    it 'performs a reverse lookup when the reverse_lookup argument is true' do
      addr = Socket.getaddrinfo(nil, 'http', :INET, :STREAM,
                                Socket::IPPROTO_TCP, 0, true)[0]

      addr[0].should == 'AF_INET'
      addr[1].should == 80

      addr[2].should be_an_instance_of(String)
      addr[2].should_not == addr[3]

      addr[3].should == '127.0.0.1'
    end

    it 'performs a reverse lookup when the reverse_lookup argument is :hostname' do
      addr = Socket.getaddrinfo(nil, 'http', :INET, :STREAM,
                                Socket::IPPROTO_TCP, 0, :hostname)[0]

      addr[0].should == 'AF_INET'
      addr[1].should == 80

      addr[2].should be_an_instance_of(String)
      addr[2].should_not == addr[3]

      addr[3].should == '127.0.0.1'
    end

    it 'performs a reverse lookup when the reverse_lookup argument is :numeric' do
      addr = Socket.getaddrinfo(nil, 'http', :INET, :STREAM,
                                Socket::IPPROTO_TCP, 0, :numeric)[0]

      addr.should == [
        'AF_INET',
        80,
        '127.0.0.1',
        '127.0.0.1',
        Socket::AF_INET,
        Socket::SOCK_STREAM,
        Socket::IPPROTO_TCP
      ]
    end
  end

  describe 'with global reverse lookups' do
    before do
      @do_not_reverse_lookup = BasicSocket.do_not_reverse_lookup

      BasicSocket.do_not_reverse_lookup = false
    end

    after do
      BasicSocket.do_not_reverse_lookup = @do_not_reverse_lookup
    end

    it 'returns an address honoring the global lookup option' do
      addr = Socket.getaddrinfo(nil, 'http', :INET)[0]

      addr[0].should == 'AF_INET'
      addr[1].should == 80

      # We don't have control over this value and there's no way to test this
      # without relying on Socket.getaddrinfo()'s own behaviour (meaning this
      # test would faily any way of the method was not implemented correctly).
      addr[2].should be_an_instance_of(String)
      addr[2].should_not == addr[3]

      addr[3].should == '127.0.0.1'
    end
  end
end
