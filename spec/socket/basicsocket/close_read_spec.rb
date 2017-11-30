require 'socket'

describe 'BasicSocket#close_read' do
  before do
    @server = Socket.new(:INET, :STREAM, 0)
  end

  it 'closes the socket for read operations' do
    @server.close_read

    proc { @server.read }.should raise_error(IOError)
  end

  it 'does not raise when called on a socket already closed for reading' do
    @server.close_read

    proc { @server.close_read }.should_not raise_error
    proc { @server.read }.should raise_error(IOError)
  end

  it 'does not fully close the socket' do
    @server.close_read
    @server.closed?.should be_false
  end

  it 'fully closes the socket if it was already closed for writing' do
    @server.close_write
    @server.closed?.should be_false

    @server.close_read
    @server.closed?.should be_true
  end

  it 'raises IOError when called on a fully closed socket' do
    @server.close

    proc { @server.close_read }.should raise_error(IOError)
  end

  it 'returns nil' do
    @server.close_read.should be_nil
  end
end
