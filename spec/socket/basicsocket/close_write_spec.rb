require 'socket'

describe 'BasicSocket#close_write' do
  before do
    @server = Socket.new(:INET, :STREAM, 0)
  end

  it 'closes the socket for write operations' do
    @server.close_write

    proc { @server.write('foo') }.should raise_error(IOError)
  end

  it 'does not raise when called on a socket already closed for writing' do
    @server.close_write

    proc { @server.close_write }.should_not raise_error
    proc { @server.write('foo') }.should raise_error(IOError)
  end

  it 'does not fully close the socket' do
    @server.close_write
    @server.closed?.should be_false
  end

  it 'fully closes the socket if it was already closed for reading' do
    @server.close_read
    @server.closed?.should be_false

    @server.close_write
    @server.closed?.should be_true
  end

  it 'raises IOError when called on a fully closed socket' do
    @server.close

    proc { @server.close_write }.should raise_error(IOError)
  end

  it 'returns nil' do
    @server.close_write.should be_nil
  end
end
