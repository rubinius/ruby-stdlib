require 'socket'

describe 'Addrinfo#unix_path' do
  it 'returns the path of a UNIX socket' do
    Addrinfo.unix('foo').unix_path.should == 'foo'
  end

  it 'raises SocketError when called on a non UNIX Addrinfo' do
    proc { Addrinfo.ip('127.0.0.1').unix_path }.should raise_error(SocketError)
  end
end
