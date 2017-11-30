require 'socket'

describe 'IPSocket#getaddress' do
  describe 'when given a hostname' do
    it 'returns the IP address of the hostname' do
      addr = IPSocket.getaddress('localhost')

      %w{127.0.0.1 ::1}.include?(addr).should == true
    end
  end

  describe 'when given an IP address' do
    it 'returns the IP address itself' do
      IPSocket.getaddress('127.0.0.1').should == '127.0.0.1'
      IPSocket.getaddress('::1').should == '::1'
    end
  end

  describe 'when given a non existing hostname' do
    it 'raises SocketError' do
      block = proc { IPSocket.getaddress('cats.are.awesome.local') }

      block.should raise_error(SocketError)
    end
  end
end
