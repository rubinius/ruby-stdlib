require 'socket'

describe 'Socket.getservbyport' do
  it 'returns the service name as a String' do
    Socket.getservbyport(514).should == 'shell'
  end

  it 'returns the service name when using a custom protocol name' do
    Socket.getservbyport(514, 'udp').should == 'syslog'
  end

  it 'raises SocketError for an unknown port number' do
    proc { Socket.getservbyport(0) }.should raise_error(SocketError)
  end
end
