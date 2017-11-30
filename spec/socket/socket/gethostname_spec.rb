require 'socket'

describe 'Socket.gethostname' do
  it 'returns the hostname as a String' do
    Socket.gethostname.should == hostname
  end
end
