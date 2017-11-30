require 'socket'

describe 'TCPSocket.gethostbyname' do
  before do
    @hostname = Socket.getaddrinfo('localhost', nil, 0, 0, 0, 0, true)[0][2]
  end

  it 'returns an Array' do
    TCPSocket.gethostbyname('localhost').should be_an_instance_of(Array)
  end

  describe 'using a hostname' do
    describe 'the returned Array' do
      before do
        @array = TCPSocket.gethostbyname('localhost')
      end

      it 'includes the canonical name as the 1st value' do
        @array[0].should == @hostname
      end

      it 'includes an array of alternative hostnames as the 2nd value' do
        @array[1].should be_an_instance_of(Array)
      end

      it 'includes the address family as the 3rd value' do
        @array[2].should be_an_instance_of(Fixnum)
      end

      it 'includes the IP addresses as all the remaining values' do
        ips = %w{::1 127.0.0.1}

        ips.include?(@array[3]).should == true

        # Not all machines might have both IPv4 and IPv6 set up, so this value is
        # optional.
        ips.include?(@array[4]).should == true if @array[4]
      end
    end
  end

  each_ip_protocol do |family, ip_address|
    describe 'the returned Array' do
      before do
        @array = TCPSocket.gethostbyname(ip_address)
      end

      it 'includes the IP address as the 1st value' do
        @array[0].should == ip_address
      end

      it 'includes an empty list of aliases as the 2nd value' do
        @array[1].should == []
      end

      it 'includes the address family as the 3rd value' do
        @array[2].should == family
      end

      it 'includes the IP address as the 4th value' do
        @array[3].should == ip_address
      end
    end
  end
end
