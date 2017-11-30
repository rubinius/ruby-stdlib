require 'socket'

describe 'IPSocket#recvfrom' do
  each_ip_protocol do |family, ip_address, family_name|
    before do
      @server = UDPSocket.new(family)
      @client = UDPSocket.new(family)

      @server.bind(ip_address, 0)
      @client.connect(ip_address, @server.connect_address.ip_port)

      @hostname = Socket.getaddrinfo(ip_address, nil)[0][2]
    end

    after do
      @client.close
      @server.close
    end

    it 'returns an Array containing up to N bytes and address information' do
      @client.write('hello')

      port = @client.local_address.ip_port
      ret  = @server.recvfrom(2)

      ret.should == ['he', [family_name, port, @hostname, ip_address]]
    end

    it 'allows specifying of flags when receiving data' do
      @client.write('hello')

      @server.recvfrom(2, Socket::MSG_PEEK)[0].should == 'he'

      @server.recvfrom(2)[0].should == 'he'
    end

    describe 'using reverse lookups' do
      before do
        @server.do_not_reverse_lookup = false

        @hostname = Socket.getaddrinfo(ip_address, nil, 0, 0, 0, 0, true)[0][2]
      end

      it 'includes the hostname in the address Array' do
        @client.write('hello')

        port = @client.local_address.ip_port
        ret  = @server.recvfrom(2)

        ret.should == ['he', [family_name, port, @hostname, ip_address]]
      end
    end
  end
end
