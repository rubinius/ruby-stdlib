require 'socket'

describe 'IPSocket#addr' do
  each_ip_protocol do |family, ip_address, family_name|
    before do
      @server = TCPServer.new(ip_address, 0)
      @port   = @server.connect_address.ip_port
    end

    after do
      @server.close
    end

    describe 'without reverse lookups' do
      before do
        @hostname = Socket.getaddrinfo(ip_address, nil)[0][2]
      end

      it 'returns an Array containing address information' do
        @server.addr.should == [family_name, @port, @hostname, ip_address]
      end
    end

    describe 'with reverse lookups' do
      before do
        @hostname = Socket.getaddrinfo(ip_address, nil, nil, 0, 0, 0, true)[0][2]
      end

      describe 'using true as the argument' do
        it 'returns an Array containing address information' do
          @server.addr(true).should == [family_name, @port, @hostname, ip_address]
        end
      end

      describe 'using :hostname as the argument' do
        it 'returns an Array containing address information' do
          @server.addr(:hostname)
            .should == [family_name, @port, @hostname, ip_address]
        end
      end

      describe 'using :cats as the argument' do
        it 'raises ArgumentError' do
          proc { @server.addr(:cats) }.should raise_error(ArgumentError)
        end
      end
    end

    describe 'with do_not_reverse_lookup disabled on socket level' do
      before do
        @server.do_not_reverse_lookup = false

        @hostname = Socket.getaddrinfo(ip_address, nil, nil, 0, 0, 0, true)[0][2]
      end

      after do
        @server.do_not_reverse_lookup = true
      end

      it 'returns an Array containing address information' do
        @server.addr.should == [family_name, @port, @hostname, ip_address]
      end
    end
  end
end
