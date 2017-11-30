require 'socket'

describe 'BasicSocket.for_fd' do
  it 'returns a new socket for a file descriptor' do
    socket1 = Socket.new(:INET, :DGRAM)
    socket2 = Socket.for_fd(socket1.fileno)

    socket2.should be_an_instance_of(Socket)
    socket2.fileno.should == socket1.fileno
  end

  it 'sets the socket into binary mode' do
    socket1 = Socket.new(:INET, :DGRAM)
    socket2 = Socket.for_fd(socket1.fileno)
    socket2.binmode?.should be_true
  end
end
