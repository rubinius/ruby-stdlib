require 'socket'

describe "Addrinfo#protocol" do
  it 'returns 0 by default' do
    Addrinfo.ip('127.0.0.1').protocol.should == 0
  end

  it 'returns a custom protocol when given' do
    addr = Addrinfo.tcp('127.0.0.1', 80)

    addr.protocol.should == Socket::IPPROTO_TCP
  end
end
