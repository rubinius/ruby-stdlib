require 'socket'

describe 'Socket.accept_loop' do
  before do
    @server = Socket.new(:INET, :STREAM)
    @client = Socket.new(:INET, :STREAM)

    @server.bind(Socket.sockaddr_in(0, '127.0.0.1'))
    @server.listen(1)
  end

  after do
    @client.close
    @server.close
  end

  describe 'using an Array of Sockets' do
    describe 'without any available connections' do
      it 'blocks the caller' do
        proc { Socket.accept_loop([@server]) }.should block_caller
      end
    end

    describe 'with available connections' do
      before do
        @client.connect(@server.getsockname)
      end

      it 'yields a Socket and an Addrinfo' do
        conn = nil
        addr = nil

        Socket.accept_loop([@server]) do |connection, address|
          conn = connection
          addr = address
          break
        end

        conn.should be_an_instance_of(Socket)
        addr.should be_an_instance_of(Addrinfo)
      end
    end
  end

  describe 'using separate Socket arguments' do
    describe 'without any available connections' do
      it 'blocks the caller' do
        proc { Socket.accept_loop(@server) }.should block_caller
      end
    end

    describe 'with available connections' do
      before do
        @client.connect(@server.getsockname)
      end

      it 'yields a Socket and an Addrinfo' do
        conn = nil
        addr = nil

        Socket.accept_loop(@server) do |connection, address|
          conn = connection
          addr = address
          break
        end

        conn.should be_an_instance_of(Socket)
        addr.should be_an_instance_of(Addrinfo)
      end
    end
  end
end
