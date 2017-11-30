require 'socket'

describe 'Socket.getnameinfo' do
  before do
    @hostname = Socket.getaddrinfo('localhost', nil, 0, 0, 0, 0, true)[0][2]
  end

  describe 'using a String as the first argument' do
    before do
      @addr = Socket.sockaddr_in(80, 'localhost')
    end

    it 'raises SocketError when using an invalid String' do
      proc { Socket.getnameinfo('cats') }.should raise_error(SocketError)
    end

    describe 'without custom flags' do
      it 'returns an Array containing the hostname and service name' do
        Socket.getnameinfo(@addr).should == [@hostname, 'http']
      end
    end

    describe 'using NI_NUMERICHOST as the flag' do
      it 'returns an Array containing the numeric hostname and service name' do
        array = Socket.getnameinfo(@addr, Socket::NI_NUMERICHOST)

        %w{127.0.0.1 ::1}.include?(array[0]).should == true

        array[1].should == 'http'
      end
    end
  end

  each_ip_protocol do |family, ip_address, family_name|
    describe 'using a 3 element Array as the first argument' do
      before do
        @addr = [family_name, 80, 'localhost']
      end

      it 'raises ArgumentError when using an invalid Array' do
        proc { Socket.getnameinfo([family_name]) }
          .should raise_error(ArgumentError)
      end

      describe 'without custom flags' do
        it 'returns an Array containing the hostname and service name' do
          array = Socket.getnameinfo(@addr)
          array.should be_an_instance_of(Array)
          array[0].should =~ /#{@hostname}/
          array[1].should == 'http'
        end
      end

      describe 'using NI_NUMERICHOST as the flag' do
        it 'returns an Array containing the numeric hostname and service name' do
          Socket.getnameinfo(@addr, Socket::NI_NUMERICHOST)
            .should == [ip_address, 'http']
        end
      end
    end

    describe 'using a 4 element Array as the first argument' do
      before do
        @addr = [family_name, 80, ip_address, ip_address]
      end

      describe 'without custom flags' do
        it 'returns an Array containing the hostname and service name' do
          array = Socket.getnameinfo(@addr)
          array.should be_an_instance_of(Array)
          array[0].should =~ /#{@hostname}/
          array[1].should == 'http'
        end

        it 'uses the 3rd value as the hostname if the 4th is not present' do
          addr = [family_name, 80, ip_address, nil]

          array = Socket.getnameinfo(addr)
          array.should be_an_instance_of(Array)
          array[0].should =~ /#{@hostname}/
          array[1].should == 'http'
        end
      end

      describe 'using NI_NUMERICHOST as the flag' do
        it 'returns an Array containing the numeric hostname and service name' do
          Socket.getnameinfo(@addr, Socket::NI_NUMERICHOST)
            .should == [ip_address, 'http']
        end
      end
    end
  end
end
